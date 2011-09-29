# Copyright 2011 Filip Brcic <brcha@gna.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="Android port of the Qt library"
HOMEPAGE="http://code.google.com/p/android-lighthouse"
SRC_URI=""

EGIT_REPO_URI="git://gitorious.org/~taipan/qt/android-lighthouse.git"
EGIT_BRANCH="stable"

LICENSE="|| ( LGPL-2.1 GPL-3 )"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

RESTRICT="strip test"

DEPEND=" dev-util/android-ndk
		 dev-util/android-sdk-update-manager"

RDEPEND="${DEPEND}"

# There is no configure, we'll use the supplied build scripts
# Here we'll just copy buildtree for armeabi-v7a
src_configure() {
	# Unset unwanted vars
	unset CHOST CTARGET CBUILD
	unset ARCH
	unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
	unset QT_PLUGIN_PATH

	ebegin "Copying buildtree for armeabi v7a"
	cp -a "${S}" "${WORKDIR}/${P}-armeabi-v7a"
	eend $?
}

src_compile() {
	local QT_VERSION=`grep '^# *define *QT_VERSION_STR' ${S}/src/corelib/global/qglobal.h | sed 's,^# *define *QT_VERSION_STR *"*\([^ ]*\)"$,\1,'`

	# First build for armeabi v5
	./androidconfigbuild.sh -q 1 -k 0 -n /opt/android-ndk/ -a armeabi -i /opt/necessitas/Android/Qt/${QT_VERSION}/armeabi || die

	# Now for armeabi v7a
	pushd ../${P}-armeabi-v7a
	./androidconfigbuild.sh -q 1 -k 0 -n /opt/android-ndk/ -a armeabi-v7a -i /opt/necessitas/Android/Qt/${QT_VERSION}/armeabi-v7a || die
	popd
}

src_install() {
	# First install armeabi v5
	emake INSTALL_ROOT="${D}" install || die
	# Now install armeabi v7a
	pushd ../${P}-armeabi-v7a
	emake INSTALL_ROOT="${D}" install || die
	popd

	fowners -R root:android /opt/necessitas
}
