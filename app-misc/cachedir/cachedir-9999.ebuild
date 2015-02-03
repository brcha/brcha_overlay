EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 git-r3

DESCRIPTION="tag/untag cache directories"
HOMEPAGE="http://liw.fi/cachedir/"
EGIT_REPO_URI="git://git.liw.fi/cachedir"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
		dev-python/cliapp"
RDEPEND="${DEPEND}"

src_compile() {
	addwrite /proc/self/comm
	distutils-r1_src_compile
}
