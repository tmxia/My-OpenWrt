#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP   第一行19.07的路径   第二行23.05的路径
#sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/luci2/bin/config_generate

# 修改主机名
#sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate

# 修正俩处错误的翻译
sed -i 's/<%:Up%>/<%:Move up%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
sed -i 's/<%:Down%>/<%:Move down%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm

# 修改opkg.conf文件-测试没有效果
#sed -i '/option overlay_root \/overlay/a #option check_signature' /etc/opkg.conf

# 设置为bootstrap默认主题-测试没有效果
#sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci/Makefile
#sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci-light/Makefile
#sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci-nginx/Makefile
#sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci-ssl-nginx/Makefile

# 拉取passwall
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview}
rm -rf feeds/luci/applications/{nikki,luci-app-nikki,luci-i18n-nikki-zh-cn}
git clone https://github.com/nikkinikki-org/OpenWrt-nikki --depth=1 package/nikki
git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall2 --depth=1 package/passwall2
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky

# 升级Dnsmasq-测试失败
#rm -rf package/network/services/dnsmasq
#wget https://thekelleys.org.uk/dnsmasq/dnsmasq-2.91.tar.gz && tar -xzvf dnsmasq-2.91.tar.gz -C package/network/services/

# 科学插件的依赖-备用
#git clone https://github.com/sbwml/openwrt_helloworld package/helloworld

# 增加 alist （在 ./scripts/feeds install -a 操作之后更换 golang 版本）
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang

# tmp fix-20230819之前编译失败回滚配置
#wget -O ./package/kernel/linux/modules/netsupport.mk https://raw.githubusercontent.com/coolsnowwolf/lede/3ef1f5ade3b8f6527bbc4eb9494138de66e07d13/package/kernel/linux/modules/netsupport.mk

# 2023-08-29 aliyundrive-webdav 编译报错回滚到2.2.1
#curl -o ./feeds/packages/multimedia/aliyundrive-webdav/Makefile https://raw.githubusercontent.com/Jason6111/OpenWrt_Personal/main/other/aliyun/Makefile

# 临时修复acpid,aliyundrive-webdav,xfsprogs,perl-html-parser,v2dat 导致的编译失败问题
#sed -i 's#flto#flto -D_LARGEFILE64_SOURCE#g' feeds/packages/utils/acpid/Makefile
#sed -i 's/stripped/release/g' feeds/packages/multimedia/aliyundrive-webdav/Makefile
#sed -i 's#SYNC#SYNC -D_LARGEFILE64_SOURCE#g' feeds/packages/utils/xfsprogs/Makefile
sed -i 's/REENTRANT -D_GNU_SOURCE/LARGEFILE64_SOURCE/g' feeds/packages/lang/perl/perlmod.mk
sed -i 's#GO_PKG_TARGET_VARS.*# #g' feeds/packages/utils/v2dat/Makefile

# 修复v2ray-plugin编译失败
rm -rf feeds/luci/applications/luci-app-mosdns
#rm -rf feeds/packages/net/{alist,adguardhome,xray*,v2ray*,v2ray*,sing*,smartdns}
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

