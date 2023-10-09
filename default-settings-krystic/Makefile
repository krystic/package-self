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

PKG_NAME:=default-settings-krystic
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/default-settings-krystic
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Default Settings by Krystic
  DEPENDS:=+luci
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/default-settings-krystic/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/99-default-settings-krystic $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,default-settings-krystic))
