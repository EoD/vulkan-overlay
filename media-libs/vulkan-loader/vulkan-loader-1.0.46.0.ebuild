# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5} )

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers.git"
	inherit git-r3
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers/archive/sdk-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Vulkan-LoaderAndValidationLayers-sdk-${PV}"
fi

inherit python-any-r1 cmake-multilib

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="validation_layer wayland X"

RDEPEND=""
DEPEND="${PYTHON_DEPS}
	validation_layer? ( dev-util/spirv-tools dev-util/glslang )
	wayland? ( dev-libs/wayland:=[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11:=[${MULTILIB_USEDEP}] )"

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=True
		-DBUILD_TESTS=False
		-DBUILD_LAYERS=$(usex validation_layer)
		-DBUILD_DEMOS=False
		-DBUILD_VKJSON=False
		-DBUILD_LOADER=True
		-DBUILD_WSI_MIR_SUPPORT=False
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
		#workaround for cmake installing into /usr/etc instead of /etc
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}"/etc
	)

	cmake-utils_src_configure
}

multilib_src_install() {
	keepdir /etc/vulkan/icd.d
	keepdir /etc/vulkan/explicit_layer.d

	default
}
