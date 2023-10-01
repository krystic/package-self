#!/bin/bash --login

function git_sparse_clone() {
	branch="$1" rurl="$2" localdir="$3" && shift 3
	git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
	cd $localdir
	git sparse-checkout init --cone
	git sparse-checkout set $@
	mv -n $@ ../
	cd ..
	rm -rf $localdir
}

function mvdir() {
	mv -n `find $1/* -maxdepth 0 -type d` ./
	rm -rf $1
}

git rm -r --cache * >/dev/null 2>&1 &
rm -rf `find ./* -maxdepth 0 -type d ! -name "diy"` >/dev/null 2>&1

#git clone --depth 1 -b 18.06 https://github.com/riverscn/luci-app-omcproxy
git clone --depth 1 https://github.com/krystic/luci-app-cifs-mount
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata
git clone --depth 1 https://github.com/sirpdboy/netspeedtest
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot
git clone --depth 1 https://github.com/tty228/luci-app-serverchan
git clone --depth 1 https://github.com/AlexZhuo/luci-app-bandwidthd.git
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff
git clone --depth 1 https://github.com/1wrt/luci-app-ikoolproxy.git
git clone --depth 1 https://github.com/krystic/luci-app-adguardhome
#git clone --depth 1 https://github.com/honwen/luci-app-aliddns
#git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper && mvdir openwrt-iptvhelper

# argon theme
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
#git clone --depth 1 https://github.com/frainzy1477/luci-app-clash
git clone --depth 1 https://github.com/Huangjoe123/luci-app-eqos
git clone --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic

# hello world
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr

# passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1	https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall && mv -n openwrt-passwall/chinadns-ng openwrt-passwall/dns2socks openwrt-passwall/dns2tcp openwrt-passwall/hysteria openwrt-passwall/ipt2socks openwrt-passwall/pdnsd-alt openwrt-passwall/trojan-go openwrt-passwall/trojan-plus openwrt-passwall/ssocks ./ ; rm -rf openwrt-passwall
svn export --force https://github.com/kenzok8/jell/trunk/brook
svn export --force https://github.com/openwrt/packages/trunk/net/shadowsocks-libev
svn export --force https://github.com/fw876/helloworld/trunk/simple-obfs
svn export --force https://github.com/fw876/helloworld/trunk/shadowsocks-rust
svn export --force https://github.com/fw876/helloworld/trunk/shadowsocksr-libev
svn export --force https://github.com/fw876/helloworld/trunk/trojan
svn export --force https://github.com/fw876/helloworld/trunk/v2ray-core
svn export --force https://github.com/fw876/helloworld/trunk/v2ray-geodata
svn export --force https://github.com/fw876/helloworld/trunk/v2ray-plugin
svn export --force https://github.com/fw876/helloworld/trunk/v2raya
svn export --force https://github.com/fw876/helloworld/trunk/xray-core
svn export --force https://github.com/fw876/helloworld/trunk/xray-plugin

git clone --depth 1 https://github.com/messense/aliyundrive-webdav aliyundrive && mv -n aliyundrive/openwrt/* ./ ; rm -rf aliyundrive
git clone --depth 1 https://github.com/messense/aliyundrive-fuse aliyundrive && mv -n aliyundrive/openwrt/* ./; rm -rf aliyundrive
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman dockerman && mv -n dockerman/applications/* ./; rm -rf dockerman

svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-diskman
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

rm -rf ./*/.git & rm -rf ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore

for e in $(ls -d luci-*/po); do
	if [[ -d $e/zh-cn && ! -d $e/zh_Hans ]]; then
		ln -s zh-cn $e/zh_Hans 2>/dev/null
	elif [[ -d $e/zh_Hans && ! -d $e/zh-cn ]]; then
		ln -s zh_Hans $e/zh-cn 2>/dev/null
	fi
done

sed -i \
	-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
	-e 's?2. Clash For OpenWRT?3. Applications?' \
	-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
	*/Makefile

sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
# sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
sed -i "s/nas/services/g" `grep nas -rl luci-app-fileassistant`
sed -i "s/NAS/Services/g" `grep NAS -rl luci-app-fileassistant`

git add .
git commit -am "update $(date +%Y-%m-%d" "%H:%M:%S)"
git push "https://github.com/krystic/package-self.git"

exit 0
