# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"


if [[ ${PV} == "9999" ]] ; then
	EGIT_COMMIT=""
	EGIT_REPO_URI="git://github.com/zbackup/zbackup.git"
	KEYWORKDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/zbackup/zbackup/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils eutils

DESCRIPTION="ZBackup, a versatile deduplicating backup tool."
HOMEPAGE="http://zbackup.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="lzo +tartool"

RDEPEND="dev-libs/openssl
		 dev-libs/protobuf
		 app-arch/xz-utils
		 lzo? ( dev-libs/lzo )
		 sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	if use tartool; then
		echo 'add_subdirectory(tartool)' >> CMakeLists.txt
	fi
}
