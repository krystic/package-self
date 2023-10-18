#
# Copyright (C) 2021 Lean <coolsnowwolf@gmail.com>
#
# Copyright (C) 2021 ImmortalWrt
# <https://immortalwrt.org>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/version.mk
include $(INCLUDE_DIR)/feeds.mk

PKG_NAME:=default-settings-krystic
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_FILE_DEPENDS:=$(PLATFORM_DIR)/ $(GENERIC_PLATFORM_DIR)/base-files/
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

ifneq ($(DUMP),1)
  STAMP_CONFIGURED:=$(strip $(STAMP_CONFIGURED))_$(shell echo $(CONFIG_TARGET_INIT_PATH) | $(MKHASH) md5)
  TARGET:=-$(BOARD)
endif

define Package/default-settings-krystic
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Default Settings by Krystic
  DEPENDS:=+luci
  PKGARCH:=all
endef

define Package/base-files/description
  This package contains custom settings and scripts for Krystic.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default

endef
Build/Compile = $(Build/Compile/Default)

define Package/default-settings-krystic/install
	mkdir -p $(1)/lib
	$(CP) ./files/lib/* $(1)/lib/
	mkdir -p $(1)/etc
	$(CP) ./files/etc/* $(1)/etc/
	$(VERSION_SED_SCRIPT) \
		$(1)/etc/krystic_banner
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/99-default-settings-krystic $(1)/etc/uci-defaults/
endef

ifneq ($(DUMP),1)
	-include $(PLATFORM_DIR)/base-files.mk
	-include $(PLATFORM_SUBDIR)/base-files.mk
endif

$(eval $(call BuildPackage,default-settings-krystic))
