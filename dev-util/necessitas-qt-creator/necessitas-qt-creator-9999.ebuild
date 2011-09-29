# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qt-creator/qt-creator-2.3.0-r2.ebuild,v 1.1 2011/09/29 00:11:00 ferringb Exp $

EAPI="4"
LANGS="cs de es fr hu it ja pl ru sl uk zh_CN"

inherit qt4-r2 multilib flag-o-matic versionator git-2
MY_PN="qtcreator"
MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Lightweight IDE for C++ development centering around Qt"
HOMEPAGE="http://necessitas.sourceforge.net/"
#SRC_URI="http://get.qt.nokia.com/${MY_PN}/${MY_P}-src.tar.gz"

EGIT_REPO_URI="git://gitorious.org/~taipan/qt-creator/android-qt-creator.git"
EGIT_BRANCH="stable"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bazaar bineditor bookmarks +botan-bundled +cmake cvs debug doc examples fakevim git
	mercurial perforce +qml qtscript rss subversion"
QTVER="4.7.4:4"
CDEPEND=">=x11-libs/qt-assistant-${QTVER}[doc?]
	>=x11-libs/qt-sql-${QTVER}
	>=x11-libs/qt-svg-${QTVER}
	debug? ( >=x11-libs/qt-test-${QTVER} )
	!qml? ( >=x11-libs/qt-gui-${QTVER} )
	qml? (
		>=x11-libs/qt-declarative-${QTVER}[private-headers]
		>=x11-libs/qt-core-${QTVER}[private-headers]
		>=x11-libs/qt-gui-${QTVER}[private-headers]
		>=x11-libs/qt-script-${QTVER}[private-headers]
	)
	qtscript? ( >=x11-libs/qt-script-${QTVER} )
	!botan-bundled? ( =dev-libs/botan-1.8* )"

DEPEND="${CDEPEND}
	!botan-bundled? ( dev-util/pkgconfig )
	dev-embedded/android-lighthouse "

RDEPEND="${CDEPEND}
	bazaar? ( dev-vcs/bzr )
	cmake? ( dev-util/cmake )
	cvs? ( dev-vcs/cvs )
	sys-devel/gdb
	examples? ( >=x11-libs/qt-demo-${QTVER} )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	subversion? ( dev-vcs/subversion )"

PLUGINS="bookmarks bineditor cmake cvs fakevim git mercurial
perforce qml qtscript subversion"

S="${WORKDIR}"/"${MY_P}"-src

src_prepare() {
	qt4-r2_src_prepare

	# bug 263087
	for plugin in ${PLUGINS}; do
		if ! use ${plugin}; then
			einfo "Disabling ${plugin} support"
			if [[ ${plugin} == "cmake" ]]; then
				plugin="cmakeprojectmanager"
			elif [[ ${plugin} == "qtscript" ]]; then
				plugin="qtscripteditor"
			elif [[ ${plugin} ==  "qml" ]]; then
				for x in qmlprojectmanager qmljsinspector qmljseditor qmljstools qmldesigner; do
					einfo "Disabling ${x} support"
					sed -i "/plugin_${x}/s:^:#:" src/plugins/plugins.pro \
						|| die "Failed to disable ${x} plugin"
					done
			fi
			# Now disable the plugins
			sed -i "/plugin_${plugin}/s:^:#:" src/plugins/plugins.pro
		fi
	done

	if use perforce; then
		ewarn
		ewarn "You have enabled perforce plugin."
		ewarn "In order to use it, you need to manually"
		ewarn "download the perforce client from http://www.perforce.com/perforce/downloads/index.html"
		ewarn
	fi
	# disable rss news on startup ( bug #302978 )
	if ! use rss; then
		einfo "Disabling RSS welcome news"
		sed -i "/m_rssFetcher->fetch/s:^:\/\/:" \
			src/plugins/welcome/communitywelcomepagewidget.cpp || die
	fi

	# add rpath to make qtcreator actual find its *own* plugins
	sed -i "/^LIBS/s:+=:& -Wl,-rpath,/opt/necessitas/QtCreator/lib :" qtcreator.pri || die
}

src_configure() {
	#the path must NOT be empty
	local qtheaders="False"
	use qml && qtheaders="/usr/include/qt4/"
	eqmake4 \
		${MY_PN}.pro \
		QT_PRIVATE_HEADERS=${qtheaders}
}

src_install() {
	# Install all into /opt/necessitas/QtCreator
	into /opt/necessitas/QtCreator

	#install wrapper
	dobin bin/${MY_PN} bin/qtpromaker
	if use qml; then
		# qmlpuppet component. Bug #367383
		dobin bin/qmlpuppet
	fi
	emake INSTALL_ROOT="${D%/}${EPREFIX}/opt/necessitas/QtCreator" install_subtargets
	if use doc;then
		emake INSTALL_ROOT="${D%/}${EPREFIX}/opt/necessitas/QtCreator" install_inst_qch_docs
	fi

	# Install missing icon
	doicon "${FILESDIR}"/necessitas.png \
		|| die "failed to install icon"
	make_desktop_entry /opt/necessitas/QtCreator/bin/qtcreator "Necessitas Qt Creator" necessitas \
		'Qt;Development;IDE' || die

	# install additional translations
	insinto /opt/necessitas/QtCreator/translations/
	for x in ${LINGUAS}; do
		for lang in ${LANGS}; do
			if [[ ${x} == ${lang} ]]; then
				cd "${S}"/share/${MY_PN}/translations
				lrelease ${MY_PN}_${x}.ts -qm ${MY_PN}_${x}.qm || die
				doins ${MY_PN}_${x}.qm
			fi
		done
	done

	fowners -R root:android /opt/necessitas
}
