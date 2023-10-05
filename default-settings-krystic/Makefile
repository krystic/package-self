#
# Copyright (C) 2016-2023 GitHub 
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=default-settings-krystic
PKG_VERSION:=3
PKG_RELEASE:=6
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/default-settings-krystic
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Default Settings by Krystic
  PKGARCH:=all
  DEPENDS:=+luci-base +luci +@LUCI_LANG_zh-cn
endef

define Build/Compile
endef

define Package/default-settings-krystic/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/krystic-default-settings $(1)/etc/uci-defaults/99-default-settings-krystic
endef

#	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
#	po2lmo ./po/zh-cn/default.po $(1)/usr/lib/lua/luci/i18n/default.zh-cn.lmo

$(eval $(call BuildPackage,default-settings-krystic))
