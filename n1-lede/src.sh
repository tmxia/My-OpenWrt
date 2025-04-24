#!/bin/bash
cd openwrt
# Add a feed source
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git helloworld https://github.com/fw876/helloworld.git;master" >> "feeds.conf.default"
