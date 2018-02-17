# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="The ctypes-based simple ImageMagick binding for Python"
HOMEPAGE="http://wand-py.org/"
SRC_URI="mirror://pypi/Wand/Wand/Wand-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/imagemagick"

S=${WORKDIR}/Wand-${PV}
