# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/SPIRV-Headers.git"
    inherit git-r3
fi

inherit eutils

DESCRIPTION="Machine-readable files from the SPIR-V Registry"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Headers"

LICENSE="Khronos"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	doheader -r include/*
	default
}

