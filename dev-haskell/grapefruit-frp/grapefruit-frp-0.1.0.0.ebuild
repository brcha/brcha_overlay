# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.14

EAPI="3"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Functional Reactive Programming core"
HOMEPAGE="http://grapefruit-project.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/arrows-0.2
		<dev-haskell/arrows-0.5
		=dev-haskell/fingertree-0.0*
		=dev-haskell/semigroups-0.8*
		>=dev-haskell/typecompose-0.3
		<dev-haskell/typecompose-0.9
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"