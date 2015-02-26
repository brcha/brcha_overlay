# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_AUTODEPS=false
inherit kde5

DESCRIPTION="Plugin based library to create window decorations"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="dev-qt/qtgui:5
		>=dev-libs/extra-cmake-modules-1.6.1
"
RDEPEND="${DEPEND}
		>=kde-frameworks/kf-env-3
"
