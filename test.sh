#!/bin/bash
sed -i \
	-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
	-e 's?2. Clash For OpenWRT?3. Applications?' \
	-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
	*/Makefile
