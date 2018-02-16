# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit dotnet

SRC_URI="http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz"

DESCRIPTION="Sonarr is a PVR for Usenet and BitTorrent users."
HOMEPAGE="https://github.com/Sonarr/Sonarr"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="
		>=dev-lang/mono-3.12.1
		media-video/mediainfo
		dev-db/sqlite"
IUSE="updater"

SLNFILE="${S}/src/NzbDrone.sln"

pkg_setup() {
	export MONO_IOMAP="case"
	dotnet_pkg_setup
}

src_unpack() {
	unpack ${A}
	# Because the tarball has NzbDrone as the root
	mv ${WORKDIR}/NzbDrone ${S}
}

src_install() {
	mkdir -p ${D}/opt/sonarr ${D}/etc/sonarr
	cp -R "${S}/" "${D}/sonarr" || die "Install failed!"
	die "Failing on purpose"
	newinitd files/sonarr.init sonarr
	cp files/sonarr.conf ${D}/etc/sonarr
}

pkg_setup() {
	enewgroup sonarr
	enewuser sonarr -l /bin/false /dev/null sonarr
}
