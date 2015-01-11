# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_PN="gitflow"
inherit eutils

DESCRIPTION="Git extensions to provide high-level repository operations for Vincent Driessen's branching model (AVH Edition)"
HOMEPAGE="https://github.com/petervanderdoes/gitflow"
SRC_URI="https://github.com/petervanderdoes/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD LGPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-vcs/git
"

DOCS=( AUTHORS Changes.mdown README.mdown )


S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	true
}

src_install() {
	emake prefix="${D}/usr" install

	[[ ${DOCS[@]} ]] && dodoc "${DOCS[@]}"
}
