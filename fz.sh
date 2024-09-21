#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
Rzk_Check()
{
if [ ! -f /etc/openvpn/auth_config.conf ]; then
	echo
	echo "检测到您还未安装 吾爱铁锈联机 系统，无法执行此脚本，请前往(www.tiexiu.vip)获取脚本搭建！"
	exit
fi
if [ ! -f /var/www/html/config.php ]; then
	echo
	echo "检测到您还未安装 吾爱铁锈联机 系统，无法执行此脚本，请前往(www.tiexiu.vip)获取脚本搭建！"
	exit
fi
}
Rzk_Fuji()
{
clear
echo
# 提示用户输入数据库账号，如果为空则使用默认账号 'default_user'
read -p "请输入主机数据库账号（默认为root）: " rzksqluser
rzksqluser=${rzksqluser:-root}
echo -e "已设置数据库账号：$rzksqluser "
echo
# 提示用户输入数据库名，如果为空则使用默认数据库名 'default_database'
read -p "请输入主机数据库库名（默认为vpndata）: " sqlname
sqlname=${sqlname:-vpndata}
echo -e "已设置数据库库名：$sqlname"
echo
# 提示用户输入数据库密码，如果为空则使用默认密码 'default_password'
read -p "请输入主机数据库密码: " rzksqlpass
rzksqlpass=${rzksqlpass:-未填写}
echo -e "已设置数据库库密码：$rzksqlpass"
echo
# 提示用户输入数据库端口，如果为空则使用默认端口 '3306'
read -p "请输入主机数据库端口（默认为3306）: " rzksqlport
rzksqlport=${rzksqlport:-3306}
echo -e "已设置数据库库端口：$rzksqlport"
echo
# 提示用户输入服务器IP，如果为空则使用默认IP '127.0.0.1'
read -p "请输入主机服务器IP: " rzksqlip
rzksqlip=${rzksqlip:-127.0.0.1}
echo -e "已设置主机服务器IP：$rzksqlip"
echo
echo "正在为您的系统进行负载，请稍等......"
sleep 3
SQL_RESULT=`mysql -h${rzksqlip} -P${rzksqlport} -u${rzksqluser} -p${rzksqlpass} -e quit 2>&1`;
SQL_RESULT_LEN=${#SQL_RESULT};
if [[ !${SQL_RESULT_LEN} -eq 0 ]];then
echo
echo "连接至主机数据库失败，请检查您的主机数据库密码后重试，脚本停止！";
exit;
fi

clear
rm -rf /etc/openvpn/auth_config.conf
echo '#!/bin/bash
mysql_host='$rzksqlip'
mysql_user='$rzksqluser'
mysql_pass='$rzksqlpass'
mysql_port='$rzksqlport'
mysql_data='$sqlname'
address='$IP'
unset_time=60
del="/root/res/del"
status_file_1="/var/www/html/openvpn_api/user-status-tcp.txt 7075 1194 tcp"
status_file_2="/var/www/html/openvpn_api/user-status-udp.txt 7079 53 udp"
sleep=3'>/etc/openvpn/auth_config.conf && chmod -R 0777 /etc/openvpn/auth_config.conf
rm -rf /var/www/html/config.php
echo '<?php
/* 请勿修改 */
define("_host_","'$rzksqlip'");
define("_user_","'$rzksqluser'");
define("_pass_","'$rzksqlpass'");
define("_port_","'$rzksqlport'");
define("_ov_","'$sqlname'");
define("_openvpn_","openvpn");
define("_iuser_","iuser");
define("_ipass_","pass");
define("_isent_","isent");
define("_irecv_","irecv");
define("_starttime_","starttime");
define("_endtime_","endtime");
define("_maxll_","maxll");
define("_other_","dlid,tian");
define("_i_","i");'>/var/www/html/config.php && chmod -R 0777 /var/www/html/config.php
systemctl disable mariadb.service >/dev/null 2>&1
	if [[ $? -eq 0 ]];then
	echo "" >/dev/null 2>&1
	else
	echo "警告！MariaDB停止失败！请手动停止MariaDB查看失败原因！脚本停止！"
	exit
	fi
	
	sleep 5
	echo
	echo "已成功为您的系统进行负载！主机IP为："$rzksqlip"！"
	exit;
}
Rzk_Zhuji()
{
	clear
	echo
# 提示用户输入数据库账号，如果为空则使用默认账号 'default_user'
read -p "请输入主机数据库账号（默认为root）: " rzksqluser
rzksqluser=${rzksqluser:-root}
echo -e "已设置数据库账号：$rzksqluser "
echo
# 提示用户输入数据库名，如果为空则使用默认数据库名 'default_database'
read -p "请输入主机数据库库名（默认为vpndata）: " sqlname
sqlname=${sqlname:-vpndata}
echo -e "已设置数据库库名：$sqlname"
echo
# 提示用户输入数据库密码，如果为空则使用默认密码 'default_password'
read -p "请输入主机数据库密码: " rzksqlpass
rzksqlpass=${rzksqlpass:-未填写}
echo -e "已设置数据库库密码：$rzksqlpass"
echo
# 提示用户输入数据库端口，如果为空则使用默认端口 '3306'
read -p "请输入主机数据库端口（默认为3306）: " rzksqlport
rzksqlport=${rzksqlport:-3306}
echo -e "已设置数据库库端口：$rzksqlport"
	echo
	echo "正在为您的系统进行负载，请稍等......"
	sleep 3
	SQL_RESULT=`mysql -hlocalhost -P${rzksqlport} -u${rzksqluser} -p${rzksqlpass} -e quit 2>&1`;
	SQL_RESULT_LEN=${#SQL_RESULT};
	if [[ !${SQL_RESULT_LEN} -eq 0 ]];then
	echo
	echo "数据库连接失败，请检查您的数据库密码后重试，脚本停止！";
	exit;
	fi
	
	iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
	service iptables save >/dev/null 2>&1
	systemctl restart iptables.service >/dev/null 2>&1
	if [[ $? -eq 0 ]];then
	echo "" >/dev/null 2>&1
	else
	echo "警告！IPtables重启失败！请手动重启IPtables查看失败原因！脚本停止！"
	exit
	fi
	mysql -hlocalhost -P${rzksqlport} -u${rzksqluser} -p${rzksqlpass} <<EOF
grant all privileges on *.* to '${rzksqluser}'@'%' identified by '${rzksqlpass}' with grant option;
flush privileges;
EOF
	systemctl restart mariadb.service >/dev/null 2>&1
	if [[ $? -eq 0 ]];then
	echo "" >/dev/null 2>&1
	else
	echo "警告！MariaDB重启失败！请手动重启MariaDB查看失败原因！脚本停止！"
	exit
	fi
	
	sleep 5
	echo
	echo "已成功为您的系统进行负载！您可以在任何搭载弱智康系统机器上对接至本服务器！"
    exit; 
}
Rzk_Mean()
{
	clear
	sleep 2
	echo
	echo -e "************************************************"
	echo -e "           欢迎使用快速负载均衡系统          "
	echo -e "************************************************"
    echo
    echo -e "1.先准备两台机器，并且两台服务器已经搭建好了联机系统"
    echo
    echo -e "2.我这里命名为A为主服务器，B为副服务器"
    echo
    echo -e "3.再A服务器上运行脚本，选择序号1：主服务器对接"
    echo
    echo -e "4.再B服务器上运行脚本，选择序号2：副服务器对接"
    echo
    echo -e "5.最后在A服务器的后台，添加B服务器的IP就可以了"
    echo
    echo -e "6.如果以后要增加C服务器，搭建好流控后直接运行脚本选择副服务器对接即可"
    echo
    echo -e "================================================"
    echo
	echo -e "请选择："
	echo
	echo -e "\033[36m 1、主机开启远程数据库权限 \033[0m \033[31m（在主机执行，主机只需开启一次，后续直接副机对接主机即可）\033[0m"
	echo ""
	echo -e "\033[36m 2、副机连接主机数据库 \033[0m \033[31m（在负载机执行，每个机子无限负载主机，仅生效最后一次负载的机器）\033[0m"
	echo
	echo -e "\033[36m 3、退出脚本！\033[0m"
	echo
	echo 
	read -p " 请输入安装选项并回车: " a
	echo
	echo
	k=$a

	if [[ $k == 1 ]];then
	Rzk_Zhuji
	exit;0
	fi
	
	if [[ $k == 2 ]];then
	Rzk_Fuji
	exit;0
	fi

	if [[ $k == 3 ]];then
	exit;0
	fi	
	
	echo -e "\033[31m 输入错误！请重新运行脚本！\033[0m "
	exit;0
}
Rzk_Logo()
{
clear
sleep 2
IP=`curl -s ip.3322.net`;
echo -e "系统检测到的IP为：\033[37m"$IP"\033[0m"
echo
echo -e "如不正确请立即停止安装选择手动输入IP搭建，否则回车继续。"
read
Rzk_Mean
}
Main() {
rm -rf $0 >/dev/null 2>&1
clear 
Rzk_Check
Rzk_Logo
}
Main
exit;0
