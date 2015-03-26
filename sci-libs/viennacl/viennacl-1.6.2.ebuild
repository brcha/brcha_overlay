# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Linear algebra library for computations on many-core architectures (GPUs, MIC)"
HOMEPAGE="http://viennacl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/ViennaCL-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opencl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ViennaCL-${PV}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTS=OFF
		)
	
	cmake-utils_src_configure
}
