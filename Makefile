# Filename: Makefile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 03 May 2024
# Last Modified: Saturday 03 October 2026, 18:22
# Edit Time: 3:43:45
# Description:
#
#        OpenWRT Makefile for openwrt-munin-node
#
# Copyright: (C) 2024-2026 Olivier Sirol <czo@free.fr>

include $(TOPDIR)/rules.mk

PKG_NAME:=openwrt-munin-node
PKG_VERSION:=1.3.2
PKG_RELEASE:=1

PKG_MAINTAINER:=Olivier Sirol <czo@free.fr>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

Build/Compile=

# too big depends for my Archer C7 v2:
#  DEPENDS:=+perl +perlbase-file +perlbase-getopt
# vs
#  DEPENDS:=+perl +perlbase-base

define Package/openwrt-munin-node
  SECTION:=utils
  CATEGORY:=Utilities
  PKGARCH:=all
  DEPENDS:=+perl +perlbase-file +perlbase-getopt
  TITLE:=Munin node for OpenWRT implemented in perl like pmmn
  URL:=https://github.com/czodroid/openwrt-munin-node
endef

define Package/openwrt-munin-node/Default/description
  Munin is a monitoring system for Unix networks.
  Munin node for OpenWRT implemented in perl like pmmn, with all plugins in /etc/munin/plugins.
endef

define Package/openwrt-munin-node/install
    $(INSTALL_DIR)  $(1)/etc/munin
	$(CP) ./files/etc/munin/* $(1)/etc/munin/
endef

define Package/openwrt-munin-node/preinst
#!/bin/sh
echo "-> rm -fr ${IPKG_INSTROOT}/etc/munin"
rm -fr ${IPKG_INSTROOT}/etc/munin
endef

define Package/openwrt-munin-node/postinst
#!/bin/sh
echo "-> running ${IPKG_INSTROOT}/etc/munin/share/munin-node-configure"
${IPKG_INSTROOT}/etc/munin/share/munin-node-configure
endef

define Package/openwrt-munin-node/postrm
#!/bin/sh
echo "-> rm -fr ${IPKG_INSTROOT}/etc/munin"
rm -fr ${IPKG_INSTROOT}/etc/munin
endef

$(eval $(call BuildPackage,openwrt-munin-node))

