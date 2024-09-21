#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
Main()
{
trap 'handle_signal' USR1
Detect_New_Session &
Loading
}
Loading()
{
rm -rf $0 >/dev/null 2>&1
clear 
echo
echo "程序载入中，请稍后..."
yum -y install wget curl openssl net-tools net-tools.x86_64 >/dev/null 2>&1
Install_Mean
}
Install_Mean()
{
clear
echo 
	echo -e "            欢迎使用流控联机APP搭建系统            "
	echo -e "请选择："
	echo
	echo -e "1、安装程序"
    echo -e "   \033[34m说明：\033[0m\033[36m仅支持Centos7.x 64位系统！\033[0m"
	echo -e 
	echo -e "2、系统负载"
    echo -e "   \033[34m说明：\033[0m\033[36m用来实现服务器共享管理.\033[0m"
    echo -e 
	echo -e "3、重置程序"
    echo -e "   \033[34m说明：\033[0m\033[36m解决部分服务器连接App没网.\033[0m"
    echo -e 
	echo -e "4、修改DNS"
    echo -e "    \033[34m说明：\033[0m\033[36m修改服务器DNS用来改善网速.\033[0m"
    echo -e 
	echo -e "0、退出脚本"
    echo -e

echo
read -p "请输入对应的数字并回车（默认全新安装）:" a
echo
k=$a
if [[ $k == 1 ]];then
Ntp_Date
fi
if [[ $k == 2 ]];then
Install_Fuzai
fi
if [[ $k == 3 ]];then
Install_Fang
fi
if [[ $k == 4 ]];then
Install_DNS
fi
Ntp_Date
}



Install_Fang (){
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config >/dev/null 2>&1
	rm -rf /etc/sysctl.conf
	echo '#流控配置
net.ipv4.ip_forward = 1
net.core.rmem_max=10485760
net.core.wmem_max=10485760
net.core.rmem_default=1048576
net.core.wmem_default=1048576' >/etc/sysctl.conf
chmod 777 /etc/sysctl.conf
sysctl -p /etc/sysctl.conf >/dev/null 2>&1
systemctl stop firewalld.service > /dev/null 2>&1
systemctl disable firewalld.service > /dev/null 2>&1
yum install iptables iptables-services -y >/dev/null 2>&1
systemctl stop iptables.service
systemctl preset iptables.service ip6tables.service >/dev/null 2>&1
systemctl start iptables.service >/dev/null 2>&1
iptables -F
service iptables save
iptables -A INPUT -s 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -d 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 138 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 440 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1024 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1195 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1196 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1197 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8091 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8128 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 123 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 161 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 636 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3389 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 6868 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 8060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3848 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
iptables -t nat -A PREROUTING -p udp --dport 67 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 68 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 69 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 123 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 636 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 161 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 5353 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 6868 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3389 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 138 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 137 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1194 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1195 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1196 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1197 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 8060 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3848 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING --dst 10.8.0.1 -p udp --dport 53 -j DNAT --to-destination 10.8.0.1:5353
iptables -t nat -A PREROUTING --dst 10.9.0.1 -p udp --dport 53 -j DNAT --to-destination 10.9.0.1:5353
iptables -t nat -A PREROUTING --dst 10.10.0.1 -p udp --dport 53 -j DNAT --to-destination 10.10.0.1:5353
iptables -t nat -A PREROUTING --dst 10.11.0.1 -p udp --dport 53 -j DNAT --to-destination 10.11.0.1:5353
iptables -t nat -A PREROUTING --dst 10.12.0.1 -p udp --dport 53 -j DNAT --to-destination 10.12.0.1:5353
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.11.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.12.0.0/24 -j MASQUERADE
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
service iptables save

systemctl restart iptables.service > /dev/null 2>&1
systemctl enable iptables.service > /dev/null 2>&1
	echo "重置完毕"
	exit 0
}

Install_DNS (){
	echo "================================================"
	echo "           欢迎使用DNS修改助手            "
	echo "================================================"
	echo
	echo "  1 - 修改为阿里云DNS（推荐）"
	echo "      提示：223.5.5.5-223.6.6.6"
	echo
	echo "  2 - 修改为腾讯云DNS"
	echo "      提示 183.60.83.19-183.60.82.98"
	echo
	echo "  3 - 修改为114 DNS"
	echo "      提示：114.114.114.114-114.114.115.115"
	echo
	echo "  4 - 修改为DNS 派"
	echo "      提示：101.226.4.6-218.30.118.6"
	echo
	echo -n "请输入安装选项并回车："
	read dns
	if [[ $dns == 1 ]];then
		echo 'nameserver 223.5.5.5
nameserver 223.6.6.6'>/etc/resolv.conf
		echo "OK!"
		exit 0
	fi
	if [[ $dns == 2 ]];then
		echo 'nameserver 183.60.83.19
nameserver 183.60.82.98'>/etc/resolv.conf
		echo "OK!"
		exit 0
	fi
	if [[ $dns == 3 ]];then
		echo 'nameserver 114.114.114.114
nameserver 114.114.115.115'>/etc/resolv.conf
		echo "OK!"
		exit 0
	fi
	if [[ $dns == 4 ]];then
		echo 'nameserver 101.226.4.6
nameserver 218.30.118.6'>/etc/resolv.conf
		echo "OK!"
		exit 0
	fi
}

Ntp_Date()
{
rm -rf /etc/localtime >/dev/null 2>&1
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime >/dev/null 2>&1
yum -y install ntpdate >/dev/null 2>&1
ntpdate time1.cloud.tencent.com >/dev/null 2>&1
sudo hwclock --systohc >/dev/null 2>&1
Check_OS
}

Check_OS()
{
if [ -f "/var/www/html" ];then
echo "
流控联机系统：检测到您已安装联机系统，如需要重新安装，请先重装服务器系统！
"
fi
Install_Auth
}


Install_Fuzai()
{
wget https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/fz.sh; chmod 777 fz.sh; ./fz.sh
}

Install_Auth()
{
Close_SELinux
}


Close_SELinux()
{
setenforce 0 >/dev/null 2>&1
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config >/dev/null 2>&1
Choose_Yum
}

update_progress() {
    local progress=$1
    local max_width=50  
    local width=$(( ($progress * max_width) / 100 ))  
    printf "\r安装进度: ["
    for i in $(seq 1 $max_width); do
        if [ $i -le $width ]; then
            printf "#"
        else
            printf "."
        fi
    done
    printf "] $progress%%"
}

Choose_Yum()
{
clear
echo "开始搭建环境（这里大概花费两分钟）"

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -qO /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
wget -qO /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo >/dev/null 2>&1
update_progress 10
yum install -y https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm >/dev/null 2>&1
update_progress 20
sed -i 's/https*:\/\/rpms.remirepo.net/https:\/\/mirrors.aliyun.com\/remi/g' /etc/yum.repos.d/remi*.repo >/dev/null 2>&1
update_progress 30
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/remi*.repo >/dev/null 2>&1
sed -i 's|^mirrorlist|#mirrorlist|' /etc/yum.repos.d/remi*.repo >/dev/null 2>&1
update_progress 40
yum clean all >/dev/null 2>&1
update_progress 50
yum makecache >/dev/null 2>&1
update_progress 60
yum -y install yum-utils jq >/dev/null 2>&1
update_progress 70
update_progress 100
echo -e "\n环境搭建完成"
Install_Command
}

Install_Options()
{
IP=`curl -s ip.3322.net`;
wangka1=`ifconfig`;wangka2=`echo $wangka1|awk '{print $1}'`;wangka=${wangka2/:/};
clear
echo -e "\033[1;42;37m搭建流控联机系统之前需要设置信息，不会填直接回车\033[0m"
echo
sleep 1

read -p "填写管理后台自定义地址后缀(回车默认Admin)：" Web
Web=${Web:-Admin}
echo -e "已设置管理后台自定义地址后缀：$Web"

echo
read -p "填写后台管理员QQ(回车默12345)：" QQ
QQ=${QQ:-12345}
echo -e "已设置后台管理员QQ：$QQ"

echo
read -p "填写后台管理员账号(回车默认admin)：" User
User=${User:-admin}
echo -e "已设置后台管理员账号：$User"

echo
read -p "填写后台管理员密码(默认随机)：" Pwd
Pwd=${Pwd:-$(date +%s%N | md5sum | head -c 6)}
echo -e "已设置后台管理员密码：$Pwd"

echo
read -p "填写后台管理员安全码(默认随机)：" Pwd2
Pwd2=${Pwd2:-$(date +%s%N | md5sum | head -c 6)}
echo -e "已设置后台管理员安全码：$Pwd2"

echo
read -p "填写数据库目录名字(默认随机)：" Sql
Sql=${Sql:-$(date +%s%N | md5sum | head -c 10)}
echo -e "已设置数据库目录名字：$Sql"

echo
read -p "填写数据库密码(默认随机)：" SqlPwd
SqlPwd=${SqlPwd:-$(date +%s%N | md5sum | head -c 10)}
echo -e "已设置数据库密码：$SqlPwd"

registration_time=$(date '+%Y-%m-%d %H:%M:%S')

sleep 1
echo "
所有安装信息已设置保存完成！
请回车开始无人全自动搭建系统："
read
clear
echo "
>>>开始搭建，预计花费几分钟，趁这个时间去喝杯茶吧！
【搭建的时候，进度条卡住是正常的，不要动它，请耐心等待】
"
sleep 5
}

Install_Dependency_File()
{
    echo "【1/6】配置环境（预计1-2分钟）"
    yum -y install openvpn >/dev/null 2>&1
    update_progress 17
    yum-config-manager --enable remi-php74 >/dev/null 2>&1
    update_progress 34
    yum install -y python3>/dev/null 2>&1
    update_progress 51
    pip3 install Flask>/dev/null 2>&1
    update_progress 68
    pip3 install flask-cors>/dev/null 2>&1
    update_progress 85
    yum install -y java-11-openjdk-devel >/dev/null 2>&1
    alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.*/bin/java >/dev/null 2>&1
    update_progress 100
    echo -e "\n"
}

Install_firewall()
{
echo "【2/6】安装并配置防火墙（预计30秒）"
systemctl stop firewalld.service > /dev/null 2>&1
update_progress 15
systemctl disable firewalld.service > /dev/null 2>&1
update_progress 27
yum install iptables iptables-services -y >/dev/null 2>&1
update_progress 31
systemctl stop iptables.service
update_progress 39
systemctl preset iptables.service ip6tables.service >/dev/null 2>&1
update_progress 43
systemctl start iptables.service >/dev/null 2>&1
update_progress 55
iptables -F
update_progress 65
service iptables save > /dev/null 2>&1
update_progress 70
iptables -A INPUT -s 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -d 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 138 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 440 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1024 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1195 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1196 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1197 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8091 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8128 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 123 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 161 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 636 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3389 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 6868 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 8060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3848 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
iptables -t nat -A PREROUTING -p udp --dport 67 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 68 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 69 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 123 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 636 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 161 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 5353 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 6868 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3389 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 138 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 137 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1194 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1195 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1196 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1197 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 8060 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3848 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING --dst 10.8.0.1 -p udp --dport 53 -j DNAT --to-destination 10.8.0.1:5353
iptables -t nat -A PREROUTING --dst 10.9.0.1 -p udp --dport 53 -j DNAT --to-destination 10.9.0.1:5353
iptables -t nat -A PREROUTING --dst 10.10.0.1 -p udp --dport 53 -j DNAT --to-destination 10.10.0.1:5353
iptables -t nat -A PREROUTING --dst 10.11.0.1 -p udp --dport 53 -j DNAT --to-destination 10.11.0.1:5353
iptables -t nat -A PREROUTING --dst 10.12.0.1 -p udp --dport 53 -j DNAT --to-destination 10.12.0.1:5353
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.11.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.12.0.0/24 -j MASQUERADE
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
service iptables save > /dev/null 2>&1
update_progress 86
systemctl restart iptables.service > /dev/null 2>&1
systemctl enable iptables.service > /dev/null 2>&1
update_progress 100
    echo -e "\n"
}

Install_Web()
{
echo "【3/6】安装WEB服务（预计1-2分钟）"
echo '#流控配置 net.ipv4.ip_forward = 1 net.core.rmem_max=10485760 net.core.wmem_max=10485760 net.core.rmem_default=1048576 net.core.wmem_default=1048576' > /etc/sysctl.conf
chmod -R 0777 /etc/sysctl.conf > /dev/null 2>&1
update_progress 5
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
update_progress 8
yum -y install epel-release > /dev/null 2>&1
update_progress 9
yum -y install telnet avahi openssl-libs openssl-devel lzo lzo-devel > /dev/null 2>&1
update_progress 10
yum -y install pam pam-devel > /dev/null 2>&1
update_progress 15
yum -y install automake pkgconfig gawk tar zip unzip net-tools psmisc gcc pkcs11-helper libxml2 libxml2-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel > /dev/null 2>&1
update_progress 17
yum -y install mariadb mariadb-server dnsmasq jre-1.7.0-openjdk crontabs lsof > /dev/null 2>&1
update_progress 19
yum install -y php74 php74-php-devel php74-php-fpm php74-php-mbstring php74-php-memcache php74-php-memcached php74-php-redis php74-php-mysqlnd php74-php-pdo php74-php-bcmath php74-php-xml php74-php-gd php74-php-gmp php74-php-igbinary php74-php-imagick php74-php-mcrypt php74-php-pdo_mysql php74-php-posix php74-php-simplexml php74-php-opcache php74-php-xsl php74-php-xmlwriter php74-php-xmlreader php74-php-swoole php74-php-zip php74-php-phalcon php74-php-yaml php74-php-yar php74-php-yaf php74-php-uuid > /dev/null 2>&1
update_progress 20
rpm -Uvh https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/liblz4-1.8.1.2-alt1.x86_64.rpm --force --nodeps > /dev/null 2>&1
update_progress 23
rpm -Uvh https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/openvpn-2.4.3-1.el7.x86_64.rpm --force --nodeps > /dev/null 2>&1
update_progress 25
systemctl start mariadb.service > /dev/null 2>&1
update_progress 26
mysqladmin -uroot password ''$SqlPwd'' > /dev/null 2>&1
update_progress 29
mysql -uroot -p''$SqlPwd'' -e 'create database vpndata;' > /dev/null 2>&1
update_progress 33
systemctl restart mariadb.service > /dev/null 2>&1
update_progress 34
echo '[nginx-stable] name=nginx stable repo baseurl=http://nginx.org/packages/centos/$releasever/$basearch/ gpgcheck=1 enabled=1 gpgkey=https://nginx.org/keys/nginx_signing.key module_hotfixes=true ' > /etc/yum.repos.d/nginx.repo > /dev/null 2>&1
update_progress 36
yum makecache > /dev/null 2>&1
update_progress 38
yum install -y nginx > /dev/null 2>&1
update_progress 40
mkdir -p /var/www/html
rm -rf /etc/nginx/conf.d/default.conf > /dev/null 2>&1
update_progress 45
wget -qO /etc/nginx/conf.d/default.conf https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/default.conf > /dev/null 2>&1
update_progress 55
sed -i 's/listen 80/listen 80/g' /etc/nginx/conf.d/default.conf > /dev/null 2>&1
update_progress 65
systemctl start nginx > /dev/null 2>&1
update_progress 67
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/ixed.7.4.lin -P /opt/remi/php74/root/usr/lib64/php/modules/ > /dev/null 2>&1
update_progress 69
echo ' extension=ixed.7.4.lin' >> /etc/opt/remi/php74/php.ini
chmod 777 /var/opt/remi/php74/lib/php/session > /dev/null 2>&1
update_progress 70
ln -s /bin/php74 /bin/php > /dev/null 2>&1
update_progress 75
systemctl start php74-php-fpm > /dev/null 2>&1
update_progress 80
rm -rf /etc/dnsmasq.conf > /dev/null 2>&1
update_progress 83
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/dnsmasq.conf -P /etc > /dev/null 2>&1
update_progress 85
chmod 0777 /etc/dnsmasq.conf > /dev/null 2>&1
update_progress 87
echo '#自定义屏蔽host文件 ' >> /etc/kangml_host
chmod 0777 /etc/kangml_host > /dev/null 2>&1
update_progress 90
echo '#广告屏蔽:列：127.0.0.1 www.tiexiu.vip ' >> /etc/AD.conf
chmod 0777 /etc/AD.conf > /dev/null 2>&1
update_progress 95
systemctl start dnsmasq.service > /dev/null 2>&1
update_progress 98
systemctl restart crond.service > /dev/null 2>&1
update_progress 100
    echo -e "\n"
}

Install_OpenVPN()
{
echo "【4/6】安装OPENVPN主程序（预计30秒）"
cd /etc/openvpn > /dev/null 2>&1
update_progress 15
rm -rf /etc/openvpn/client /etc/openvpn/server > /dev/null 2>&1
update_progress 21
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/openvpn.zip > /dev/null 2>&1
update_progress 25
cd /etc/openvpn > /dev/null 2>&1
update_progress 36
unzip -o openvpn.zip > /dev/null 2>&1
update_progress 43
rm -rf openvpn.zip > /dev/null 2>&1
update_progress 55
chmod 0777 -R /etc/openvpn > /dev/null 2>&1
update_progress 67
sed -i 's/newpass/'$SqlPwd'/g' /etc/openvpn/auth_config.conf > /dev/null 2>&1
update_progress 78
sed -i 's/服务器IP/'$IP'/g' /etc/openvpn/auth_config.conf > /dev/null 2>&1
update_progress 82
cd
cd /etc/systemd/system > /dev/null 2>&1
update_progress 85
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/server.zip > /dev/null 2>&1
update_progress 89
unzip -o server.zip > /dev/null 2>&1
update_progress 93
rm -rf server.zip > /dev/null 2>&1
update_progress 95
chmod 0777 -R /etc/systemd/system > /dev/null 2>&1
update_progress 100
    echo -e "\n"
}

Install_RuoZhiKang()
{
echo "【5/6】安装流控联机系统（预计30秒）"
cd
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/shvpn -O shvpn > /dev/null 2>&1
update_progress 10
chmod 777 shvpn > /dev/null 2>&1
update_progress 15
./shvpn 1 > /dev/null 2>&1
update_progress 20
systemctl start crond.service > /dev/null 2>&1
update_progress 25
if ! crontab -l > /dev/null 2>&1; then
    echo "Creating empty crontab for root" > /dev/null 2>&1
    echo "" | crontab - > /dev/null 2>&1
fi
crontab -l > /tmp/crontab1200
echo '* * * * * ./res/check_files.sh' >> /tmp/crontab1200
echo '55 23 * * * php /var/www/html/admin/cron.php #每天23:55统计用户和代理' >> /tmp/crontab1200
crontab /tmp/crontab1200 > /dev/null 2>&1
systemctl restart crond.service > /dev/null 2>&1
mkdir -p /etc/rate.d/
chmod -R 0777 /etc/rate.d/ > /dev/null 2>&1
update_progress 29
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/res.zip > /dev/null 2>&1
update_progress 30
unzip -o res.zip > /dev/null 2>&1
update_progress 35
chmod -R 0777 /root > /dev/null 2>&1
update_progress 39
rm -rf /root/res.zip > /dev/null 2>&1
update_progress 40
mv /root/res/kangml.service /lib/systemd/system/kangml.service > /dev/null 2>&1
update_progress 45
chmod -R 0777 /lib/systemd/system/kangml.service > /dev/null 2>&1
update_progress 49
systemctl enable kangml.service > /dev/null 2>&1
cd /bin > /dev/null 2>&1
update_progress 50
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/bin.zip > /dev/null 2>&1
update_progress 53
cd /bin > /dev/null 2>&1
update_progress 55
unzip -o bin.zip > /dev/null 2>&1
update_progress 57
rm -rf /bin/bin.zip > /dev/null 2>&1
update_progress 58
chmod -R 0777 /bin > /dev/null 2>&1
update_progress 60
rm -rf /var/www/html > /dev/null 2>&1
update_progress 65
cd /var/www > /dev/null 2>&1
update_progress 69
wget -q https://github.com/404days/cs23124/blob/220bce6fd184daec1fd86721c6ebf8b9d0124bf1/T.zip > /dev/null 2>&1
update_progress 70
unzip -o T.zip > /dev/null 2>&1
update_progress 72
rm -rf T.zip > /dev/null 2>&1
update_progress 75
chmod 0777 -R /var/www/html > /dev/null 2>&1
update_progress 78
mv /var/www/html/admin /var/www/html/$Web > /dev/null 2>&1
update_progress 80
sed -i 's/admin888/'$User'/g' /var/www/vpndata.sql > /dev/null 2>&1
update_progress 82
sed -i 's/pass888/'$Pwd'/g' /var/www/vpndata.sql > /dev/null 2>&1
update_progress 84
sed -i 's/服务器IP/'$IP'/g' /var/www/vpndata.sql > /dev/null 2>&1
update_progress 86
sed -i 's/312741710/'$encrypted_data'/g' /var/www/vpndata.sql > /dev/null 2>&1
update_progress 88
sed -i 's/12345/'$QQ'/g' /var/www/vpndata.sql > /dev/null 2>&1
update_progress 95
mysql -uroot -p''$SqlPwd'' vpndata < /var/www/vpndata.sql > /dev/null 2>&1
update_progress 98
rm -rf /var/www/vpndata.sql > /dev/null 2>&1
update_progress 99
sed -i 's/newpass/'$SqlPwd'/g' /var/www/html/config.php > /dev/null 2>&1
update_progress 100
echo ''$Pwd2'' > /var/www/auth_key.access
mv /var/www/html/phpmyadmin /var/www/html/$Sql > /dev/null 2>&1
    echo -e "\n"
}

Install_Check()
{
echo "【6/6】检查安装是否完成"
systemctl restart iptables.service > /dev/null 2>&1
update_progress 15
systemctl restart mariadb.service > /dev/null 2>&1
update_progress 27
systemctl restart nginx > /dev/null 2>&1
update_progress 39
systemctl restart php74-php-fpm > /dev/null 2>&1
update_progress 51
systemctl restart dnsmasq.service > /dev/null 2>&1
update_progress 65
systemctl restart crond.service > /dev/null 2>&1
update_progress 89
systemctl restart openvpn@server-tcp > /dev/null 2>&1
update_progress 96
systemctl restart openvpn@server-udp > /dev/null 2>&1
update_progress 100
    echo -e "\n"
}


Install_authority()
{
sudo chown root:root /bin/sudo
sudo chmod 4755 /bin/sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" > /dev/null 2>&1
    exit 1
fi
cp /etc/sudoers /etc/sudoers.bak
cat <<EOL >> /etc/sudoers
apache ALL=NOPASSWD: /bin/systemctl start 50001.service, /bin/systemctl status 50001.service, /bin/systemctl stop 50001.service
apache ALL=NOPASSWD: /bin/systemctl start 50002.service, /bin/systemctl status 50002.service, /bin/systemctl stop 50002.service
apache ALL=NOPASSWD: /bin/systemctl start 50003.service, /bin/systemctl status 50003.service, /bin/systemctl stop 50003.service
apache ALL=NOPASSWD: /bin/systemctl start 50004.service, /bin/systemctl status 50004.service, /bin/systemctl stop 50004.service
apache ALL=NOPASSWD: /bin/systemctl start 50005.service, /bin/systemctl status 50005.service, /bin/systemctl stop 50005.service
apache ALL=NOPASSWD: /bin/systemctl start 50006.service, /bin/systemctl status 50006.service, /bin/systemctl stop 50006.service
apache ALL=NOPASSWD: /bin/systemctl start 50007.service, /bin/systemctl status 50007.service, /bin/systemctl stop 50007.service
apache ALL=NOPASSWD: /bin/systemctl start 50008.service, /bin/systemctl status 50008.service, /bin/systemctl stop 50008.service
apache ALL=NOPASSWD: /bin/systemctl start 50009.service, /bin/systemctl status 50009.service, /bin/systemctl stop 50009.service
apache ALL=NOPASSWD: /bin/systemctl start 50010.service, /bin/systemctl status 50010.service, /bin/systemctl stop 50010.service
apache ALL=(ALL) NOPASSWD: /bin/rm
EOL
echo "Permissions added successfully to /etc/sudoers" > /dev/null 2>&1
    echo -e "\n"
}

Install_complete()
{
clear
echo "
恭喜您！流控联机系统搭建成功啦~
-----------------------------------
管理员后台: http://"$IP":80/"$Web"
管理员账号: "$User"
管理员密码: "$Pwd"
管理员口令: "$Pwd2"
-----------------------------------
数据库地址: http://"$IP":80/"$Sql"
数据库账号: root
数据库密码: "$SqlPwd"
-----------------------------------
代理中心: http://"$IP":80/daili
用户中心: http://"$IP":80
-----------------------------------
重启VPN：vpn restart
关闭VPN：vpn stop
解锁管理后台：onadmin
锁定管理后台：offadmin
开端口：port
进程守护：shvpn
-----------------------------------
安装信息保存在/home/messages.txt
" >> /home/messages.txt
cat /home/messages.txt
}

Install_Last()
{
echo "恭喜您，搭建完成！


输入回车结束搭建，并重启VPN："
read
vpn restart
shvpn 3 > /dev/null 2>&1
shvpn 4 > /dev/null 2>&1
shvpn 3
sed -i "s/FasAUTH.bin/kangml_auth.bin/g" /var/www/html/''$Web''/admin.php > /dev/null 2>&1
echo "感谢使用流控一键搭建OpenVpn脚本~"
exit;0
}

handle_signal() {
    echo
    echo -e "\033[31m请不要花样作死...\033[0m"
    exit 1
}

Detect_New_Session() {
    parent_pid=$$
    initial_sessions=$(who | awk '{print $2}' | sort | uniq)
    while true; do
        current_sessions=$(who | awk '{print $2}' | sort | uniq)
        for session in $current_sessions; do
            if [[ ! $initial_sessions =~ $session ]]; then
                kill -USR1 $parent_pid
                return
            fi
        done
        sleep 5
    done
}

Install_Command()
{
	Install_Options
	Install_Dependency_File
	Install_firewall
	Install_Web
	Install_OpenVPN
	Install_RuoZhiKang
	Install_Check
	Install_authority
	Install_complete
	Install_Last
}

Main
exit;0
