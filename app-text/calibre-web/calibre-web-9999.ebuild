# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils user git-r3 python-utils distutils-r1

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )
EGIT_REPO_URI="https://github.com/janeczku/calibre-web.git"

DESCRIPTION="Web app for browsing, reading and downloading eBooks stored in a Calibre database"
HOMEPAGE="https://github.com/janeczku/calibre-web"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="
	dev-python/setuptools
	dev-python/Babel>=1.3
	dev-python/flask-babel==0.11.1
	dev-python/flask-login>=0.3.2
	dev-python/flask-principal>=0.3.2
	dev-python/flask>=0.11
	dev-python/iso_639>=0.4.5
	dev-python/PyPDF2==1.26.0
	dev-python/pytz>=2016.10
	dev-python/requests>=2.11.1
	dev-python/sqlalchemy>=0.8.4
	www-servers/tornado>=4.1
	dev-python/unidecode>=0.04.19
	dev-python/wand>=0.4.4
"

#MY_PN=""

S=${WORKDIR}/${PN}

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_install() {
	# TODO: There isn't a gentoo ebuild for wand.
	#If the bio-overlay is present then we can skip Wand install
	#python_foreach_impl python_domodule Wand>=0.4.4

	python_foreach_impl python_domodule cps

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	keepdir /var/lib/${PN}
	fowners -R ${PN}:${PN} /var/lib/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}

	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	#newins "${FILESDIR}/${PN}.logrotate" ${PN}

	insinto "/usr/share/"
	doins -r "${S}"

	python_foreach_impl python_fix_shebang cps.py
	python_foreach_impl python_newscript cps.py ${PN}
}
