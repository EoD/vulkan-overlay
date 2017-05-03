# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/SPIRV-Tools.git"
    inherit git-r3
else
	SRC_URI="https://github.com/KhronosGroup/SPIRV-Tools/archive/v${PV}.tar.gz -> SPIRV-Tools-${PV}.tar.gz"
    S="${WORKDIR}/SPIRV-Tools-${PV}"
	KEYWORDS="~amd64"
fi

inherit eutils cmake-utils

DESCRIPTION="SPIR-V developer tools"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Tools"

LICENSE="Khronos"
SLOT="0"
IUSE=""

DEPEND="dev-util/spirv-headers"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSPIRV-Headers_SOURCE_DIR:STRING=/usr
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}
