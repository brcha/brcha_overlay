# Copyright 2011 Filip Brcic <brcha@gna.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Akonadi Google is a set of Akonadi resources providing access to various Google services like Google Contacts or Google Calendar from KDE PIM applications."
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-google"
LICENSE="GPL-3"

SLOT="4"

KEYWORDS="~x86 ~amd64"

IUSE="debug"

DEPEND=" >=kde-base/kdelibs-4.6
		 >=kde-base/kdepimlibs-4.4
		 dev-libs/qjson
		 dev-libs/libxslt
		 dev-libs/boost"

RDEPEND="${DEPEND}"

#S="${WORKDIR}/${P}"

src_configure() {
	local mycmakeargs=(-DUSE_KCAL=TRUE)
	kde4-base_src_configure
}
