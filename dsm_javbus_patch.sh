#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

clear;

# VAR 	******************************************************************
vAction=$1;
# Logo 	******************************************************************
CopyrightLogo="
                DS Video JavBus 搜刮器补丁                                          
                                                                            
==========================================================================";
echo "$CopyrightLogo";
# Function List	*******************************************************************************
function install()
{
	cd /tmp/;
	#wget https://bootstrap.pypa.io/ez_setup.py -O - | python && easy_install pip && pip install requests && pip install bs4 && pip install lxml

	mv /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php.javback
	mv /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php.javback

	wget --no-check-certificate https://github.com/crazykuma/dsm_plugins/raw/master/dsm_javbus_patch.tar -O dsm_javbus_patch.tar;
	tar -xvf dsm_javbus_patch.tar

	cp -rfa ./dsm_javbus_patch/syno_themoviedb /var/packages/VideoStation/target/plugins/;
	cp -rfa ./dsm_javbus_patch/syno_synovideodb /var/packages/VideoStation/target/plugins/;

	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/list.py
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/data.py
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php

	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php
	cd -
	echo '==========================================================================';
	echo "恭喜, DS Video JavBus 搜刮器补丁  安装完成！";
	echo '==========================================================================';
}
function upgrade()
{
	cd /tmp/;

	wget --no-check-certificate https://github.com/crazykuma/dsm_plugins/raw/master/dsm_javbus_patch.tar -O dsm_javbus_patch.tar;
	tar -xvf dsm_javbus_patch.tar

	cp -rfa ./dsm_javbus_patch/syno_themoviedb /var/packages/VideoStation/target/plugins/;
	cp -rfa ./dsm_javbus_patch/syno_synovideodb /var/packages/VideoStation/target/plugins/;

	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/list.py
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/data.py
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php

	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php
	cd -
	echo '==========================================================================';
	echo "恭喜, DS Video JavBus 搜刮器补丁  更新完成！";
	echo '==========================================================================';
}
function uninstall()
{	
	rm /var/packages/VideoStation/target/plugins/syno_themoviedb/list.py
	rm /var/packages/VideoStation/target/plugins/syno_themoviedb/data.py
	
	mv -f /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php.javback /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	mv -f /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php.javback /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php
	
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chmod 0755 /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php

	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_themoviedb/search.php
	chown VideoStation:VideoStation /var/packages/VideoStation/target/plugins/syno_synovideodb/search.php
	
	
	echo 'DS Video JavBus Patch 卸载完成！';
	echo '==========================================================================';
}

# SHELL 	******************************************************************
if [ "$vAction" == 'install' ]; then
	if [ ! -f "/var/packages/VideoStation/target/plugins/syno_themoviedb/search.php.javback" ]; then
		install;
	else
		echo '你已经安装过 DS Video JavBus 搜刮器补丁. ';
		echo '==========================================================================';
		exit 1;
	fi;
elif [ "$vAction" == 'upgrade' ]; then
	if [ ! -f "/var/packages/VideoStation/target/plugins/syno_themoviedb/search.php.javback" ]; then
		echo '你还没安装过 installed DS Video JavBus 搜刮器补丁，无法更新. ';
		echo '==========================================================================';
		exit 1;
	else
		upgrade;
	fi;
elif [ "$vAction" == 'uninstall' ]; then
	if [ ! -f "/var/packages/VideoStation/target/plugins/syno_themoviedb/search.php.javback" ]; then
		echo '你还没安装过 installed DS Video JavBus 搜刮器补丁，无需卸载. ';
		echo '==========================================================================';
		exit 1;
	else
		uninstall;
	fi;
else
	echo '错误的命令';
	echo '==========================================================================';
	exit 1
fi;
