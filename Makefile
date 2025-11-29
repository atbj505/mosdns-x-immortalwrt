include $(TOPDIR)/rules.mk

PKG_NAME:=mosdns-x
PKG_VERSION:=25.11.11
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pmkol/mosdns-x.git
PKG_SOURCE_VERSION:=HEAD
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

# 不使用 OpenWrt 的 go（版本太低）
include $(INCLUDE_DIR)/package.mk

define Package/mosdns-x
  SECTION:=net
	CATEGORY:=Network
	TITLE:=mosdns-x DNS server
	URL:=https://github.com/pmkol/mosdns-x
endef

define Package/mosdns-x/conffiles
/etc/mosdns-x/
endef

# 手动调用 system Go 1.25.4
define Build/Compile
	cd $(PKG_BUILD_DIR) && \
	go build -trimpath -ldflags "-s -w" -o mosdns-x ./cmd/mosdnsx
endef

define Package/mosdns-x/install
	$(INSTALL_DIR) $(1)/usr/bin
	 $(INSTALL_BIN) $(PKG_BUILD_DIR)/mosdns-x $(1)/usr/bin/mosdns-x
endef

$(eval $(call BuildPackage,mosdns-x))
