# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit dotnet

P=NzbDrone

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
}

src_prepare() {
	mono "${S}/tools/nuget/nuget.exe" restore "${SLNFILE}"
}

src_compile() {
	exbuild "${SLNFILE}" /p:AllowedReferenceRelatedFileExtensions=.pdb
}

src_install() {
	rm "${S}/src/_output/Newtonsoft.Json.*"
	cp "${S}/src/packages/Newtonsoft.Json.*/lib/net35/*.dll" "${S}/src/_output"
	cp "${S}/src/packages/Newtonsoft.Json.*/lib/net35/*.dll" "${S}/src/_output/NzbDrone.Update"
	egacinstall
}
