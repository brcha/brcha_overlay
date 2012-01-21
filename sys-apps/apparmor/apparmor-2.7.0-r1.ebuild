# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs versionator

DESCRIPTION="Userspace utils and init scripts for the AppArmor application security system"
HOMEPAGE="http://apparmor.net/"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc systemd"

DEPEND="dev-lang/perl
	sys-devel/bison
	sys-devel/flex
	doc? ( dev-tex/latex2html )"
RDEPEND=""

S=${WORKDIR}/apparmor-${PV}/parser

#src_prepare() {
#	epatch "${FILESDIR}"/${P}-makefile.patch
#}

src_compile()  {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" arch manpages
	use doc && emake pdf
}

src_install() {
	emake DESTDIR="${D}" arch manpages install

	dodir /etc/apparmor.d

	# Install profiles
	emake DESTDIR="${D}" -C ../profiles install

	newinitd "${FILESDIR}"/${PN}-init ${PN}
	newconfd "${FILESDIR}"/${PN}-confd ${PN}

	dodoc README
	use doc && dodoc techdoc.pdf

	use systemd && dodir /lib/apparmor
	use systemd && exeinto /lib/apparmor
#	use systemd && doexe rc.apparmor.functions
	use systemd && doexe ${FILESDIR}/rc.apparmor.systemd
	use systemd && insinto /lib/systemd/system
	use systemd && doins ${FILESDIR}/apparmor.service
}
