# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.14

EAPI="3"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Declarative user interface programming"
HOMEPAGE="http://grapefruit-project.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/arrows-0.2
		<dev-haskell/arrows-0.5
		>=dev-haskell/colour-1.0
		<dev-haskell/colour-2.4
		>=dev-haskell/fraction-0.0.1
		<dev-haskell/fraction-0.2
		=dev-haskell/grapefruit-frp-0.1*
		=dev-haskell/grapefruit-records-0.1*
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
