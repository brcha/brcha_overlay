# Copyright 2011 Filip Brcic <brcha@gna.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2 subversion

ESVN_REPO_URI="http://qxmlrpc.googlecode.com/svn/trunk/"

DESCRIPTION="QT4 based XML-RPC library"
HOMEPAGE="http://code.google.com/p/qxmlrpc/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen ) "
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/01_build_targets.patch
	"${FILESDIR}"/02_fix_unittest.patch
	"${FILESDIR}"/03_staticlib_removed.patch
	"${FILESDIR}"/04_client.h_include_fix.patch
	"${FILESDIR}"/05_do_not_link_gui.patch )

src_prepare() {
	subversion_src_prepare
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 'CONFIG += nostrip staticlib'
}

src_compile() {
	emake
	emake distclean
	eqmake4 'CONFIG += nostrip dll'
	emake

	if use doc; then
		doxygen qxmlrpc.doxy
	fi
}

src_install() {
	insinto /usr/include/${PN}
	doins xmlrpc/{client,response,request,server{,introspection},variant}.h

	dolib.so libqxmlrpc.so.1.0.0
	dolib.a  libqxmlrpc.a

	if use doc; then
		dohtml doc/html/*
	fi
}
