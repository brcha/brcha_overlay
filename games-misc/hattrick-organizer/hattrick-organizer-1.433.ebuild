# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

RELEASE="${PV//./}_r2501"

DEPEND=""

RDEPEND="virtual/jre"

SRC_URI="mirror://sourceforge/project/ho1/ho1/${PV}/HO_${RELEASE}.deb"

KEYWORDS="-* amd64 x86"

SLOT=0

S="${WORKDIR}"

src_unpack() {
    unpack HO_${RELEASE}.deb
    unpack ./data.tar.gz
}

src_configure() { :; }

src_compile() { :; }

src_install() {
    dodir /usr

    cp -aR ${S}/usr/* ${ED}/usr/
}
