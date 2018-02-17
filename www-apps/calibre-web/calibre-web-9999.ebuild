# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit eutils user git-r3 distutils-r1


EGIT_REPO_URI="https://github.com/janeczku/calibre-web.git"

DESCRIPTION="Web app for browsing, reading and downloading eBooks stored in a Calibre database"
HOMEPAGE="https://github.com/janeczku/calibre-web"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/flask-babel-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/flask-principal-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/flask-0.11[${PYTHON_USEDEP}]
	>=dev-python/iso_639-0.4.5[${PYTHON_USEDEP}]
	=dev-python/PyPDF2-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2016.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.11.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.8.4[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.1[${PYTHON_USEDEP}]
	>=dev-python/unidecode-0.04.19[${PYTHON_USEDEP}]
	>=dev-python/wand-0.4.0[${PYTHON_USEDEP}]
"

#MY_PN="calibre-web"

S=${WORKDIR}/${P}

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare() {
	cp -v "${FILESDIR}/setup.py" ${S} || die "Failed to copy setup.py"
	true;
}

src_install() {
	python_foreach_impl python_domodule cps

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	keepdir /var/lib/${PN}
	fowners -R ${PN}:${PN} /var/lib/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}
	doins babel.cfg

	#insinto /etc/logrotate.d
	#insopts -m0644 -o root -g root
	#newins "${FILESDIR}/${PN}.logrotate" ${PN}

	python_foreach_impl python_fix_shebang cps.py
	python_foreach_impl python_newscript cps.py ${PN}

	mkdir -p ${D}/var/log
	touch ${D}/var/log/${PN}.log
	fowners ${PN}:${PN} /var/log/${PN}.log
}

pkg_info() {
	echo "First start will fail due to default logging file being in the cps directory."
	echo "Run the following after it failed to start to fix the log directory"
	echo  sqlite3 /var/lib/calibre-web/settings.db "UPDATE settings SET config_logfile = '/var/log/calibre-web.log' WHERE id = 1;"
}
