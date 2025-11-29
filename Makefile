include $(TOPDIR)/rules.mk

PKG_NAME:=mosdnsx
PKG_VERSION:=25.11.11
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/pmkol/mosdns-x/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=skip

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

# 不使用 OpenWrt 的 go（版本太低）
include $(INCLUDE_DIR)/package.mk

define Package/mosdnsx
  SECTION:=net
	CATEGORY:=Network
	TITLE:=mosdns-x DNS server
	URL:=https://github.com/pmkol/mosdns-x
endef

define Package/mosdnsx/conffiles
/etc/mosdnsx/
endef

# 手动调用 system Go 1.25.4
define Build/Compile
	cd $(PKG_BUILD_DIR) && \
	go build -trimpath -ldflags "-s -w" -o mosdnsx ./cmd/mosdnsx
endef

define Package/mosdnsx/install
	$(INSTALL_DIR) $(1)/usr/bin
	 $(INSTALL_BIN) $(PKG_BUILD_DIR)/mosdnsx $(1)/usr/bin/mosdnsx
endef

$(eval $(call BuildPackage,mosdnsx))
