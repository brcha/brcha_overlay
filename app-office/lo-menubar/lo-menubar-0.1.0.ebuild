# Copyright 2011 Filip Brcic <brcha@gna.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils base
DESCRIPTION="A LibreOffice extension to send the menubar structure through DBusMenu."
HOMEPAGE="https://launchpad.net/lo-menubar"

SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"


LICENSE="LGPL-3"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=">=dev-libs/libdbusmenu-0.3.99
		>=app-office/libreoffice-3.4[odk]
		x11-libs/libX11"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/fix-libreoffice-generic+gentoo-versions.patch )

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${S}/waf" \
		configure \
		"--prefix=${EPREFIX}/usr"
}

src_compile() {
	"${S}/waf"
}

src_install() {
	"${S}/waf" install --destdir="${D}"

	base_src_install_docs
}

