#!/bin/bash **ADAM ADD LYNIS**

echo "Run as root; confirm forensics complete?"

read varanswer

if [ "varanswer" = yes ]; then
  echo "starting "
else
  exit
fi

apt-get update -y
apt-get dist-upgrade

#Removing unwanted programs/services
apt-get remove ftp
apt-get remove pure-ftp
apt-get remove nmap
apt-get remove zanmap
apt-get remove john
apt-get remove netcat
apt-get remove wireshark
apt-get remove ophcrack
apt-get remove telnet
apt-get remove remote-login-service vino remmina remmina-common
apt-get remove rstatd
apt-get remove .*samba.* .*smb.*

#Misch
 unalias -a
  PASSMAX="$(grep -n 'PASS_MAX_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMAX}s/.*/PASS_MAX_DAYS	90/" /etc/login.defs > /var/local/temp1.txt
    PASSMIN="$(grep -n 'PASS_MIN_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMIN}s/.*/PASS_MIN_DAYS	10/" /var/local/temp1.txt > /var/local/temp2.txt
    PASSWARN="$(grep -n 'PASS_WARN_AGE' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSWARN}s/.*/PASS_WARN_AGE	7/" /var/local/temp2.txt > /var/local/temp3.txt
    mv /etc/login.defs /etc/login.defs.old
    mv /var/local/temp3.txt /etc/login.defs
    rm /var/local/temp1.txt /var/local/temp2.txt
	
	cp /etc/pam.d/common-auth /etc/pam.d/common-auth.old
    echo "auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800" >> /etc/pam.d/common-auth
	
#Disable ALL remote logons through ssh and all for root as a whole
cat > /etc/ssh/sshd_config <<"__EOF__"
Authentication:

LoginGraceTime 2m
PermitRootLogin no
StrictModes yes
MaxAuthTries 0
MaxSessions 0

PubkeyAuthentication yes
__EOF__

systemctl reload sshd.service

cat> /etc/security/access.conf <<"__EOF__"
-:ALL:ALL EXCEPT LOCAL
__EOF__

#Configure auto-logout
cat > /etc/profile.d/autologout.sh <<"__EOF__"
TMOUT=300
readonly TMOUT
export TMOUT
__EOF__

chmod +x /etc/profile.d/autologout.sh

#Install AVG/Scan outputs to /etc/avgscan.log
wget -c http://download.avgfree.com/filedir/inst/avg85flx-r874-a3473.i386.deb
dpkg -i avg85flx-r874-a3473.i386.deb
avgctl --start
avgupdate
cd /etc
touch avgscan.log
avgscan / > avgscan.log
cd


#Rootkit Scans-Write to /etc/rootkits.log--rootkits2.log
apt-get install chkrootkit -y
cd /etc
touch rootkits.log
chkrootkit -q > rootkits.log
cd
apt-get install rkhunter -y
rkhunter --update
cd /etc
touch rootkits2.log
rkhunter --check > rootkits2.log
cd

sudo apt install firefox -y

#Configures ufw
apt-get install ufw -y
ufw enable
ufw deny 23
ufw deny 2049
ufw deny 515
ufw deny 111

#Delete personal file types
find / -name '*.mp3' -type f -delete
find / -name '*.mov' -type f -delete
find / -name '*.mp4' -type f -delete
find / -name '*.avi' -type f -delete
find / -name '*.mpg' -type f -delete
find / -name '*.mpeg' -type f -delete
find / -name '*.flac' -type f -delete
find / -name '*.m4a' -type f -delete
find / -name '*.flv' -type f -delete
find / -name '*.ogg' -type f -delete
find /home -name '*.gif' -type f -delete
find /home -name '*.png' -type f -delete
find /home -name '*.jpg' -type f -delete
find /home -name '*.jpeg' -type f -delete

#Drops unwanted service-related ports and bogons
apt-get install -y iptables
mkdir /iptables/
touch /iptables/rules.v4.bak
touch /iptables/rules.v6.bak
iptables-save > /iptables/rules.v4.bak
ip6tables-save > /iptables/rules.v6.bak
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 23 -j DROP
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 2049 -j DROP
iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 2049 -j DROP
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 6000:6009 -j DROP
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 7100 -j DROP
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 515 -j DROP
iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 515 -j DROP
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 111 -j DROP
iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 111 -j DROP
iptables -A INPUT -p all -s localhost  -i eth0 -j DROP
iptables -A INPUT -s 127.0.0.0/8 -i $interface -j DROP
iptables -A INPUT -s 0.0.0.0/8 -j DROP
iptables -A INPUT -s 100.64.0.0/10 -j DROP
iptables -A INPUT -s 169.254.0.0/16 -j DROP
iptables -A INPUT -s 192.0.0.0/24 -j DROP
iptables -A INPUT -s 192.0.2.0/24 -j DROP
iptables -A INPUT -s 198.18.0.0/15 -j DROP
iptables -A INPUT -s 198.51.100.0/24 -j DROP
iptables -A INPUT -s 203.0.113.0/24 -j DROP
iptables -A INPUT -s 224.0.0.0/3 -j DROP
iptables -A OUTPUT -d 127.0.0.0/8 -o $interface -j DROP
iptables -A OUTPUT -d 0.0.0.0/8 -j DROP
iptables -A OUTPUT -d 100.64.0.0/10 -j DROP
iptables -A OUTPUT -d 169.254.0.0/16 -j DROP
iptables -A OUTPUT -d 192.0.0.0/24 -j DROP
iptables -A OUTPUT -d 192.0.2.0/24 -j DROP
iptables -A OUTPUT -d 198.18.0.0/15 -j DROP
iptables -A OUTPUT -d 198.51.100.0/24 -j DROP
iptables -A OUTPUT -d 203.0.113.0/24 -j DROP
iptables -A OUTPUT -d 224.0.0.0/3 -j DROP
iptables -A OUTPUT -s 127.0.0.0/8 -o $interface -j DROP
iptables -A OUTPUT -s 0.0.0.0/8 -j DROP
iptables -A OUTPUT -s 100.64.0.0/10 -j DROP
iptables -A OUTPUT -s 169.254.0.0/16 -j DROP
iptables -A OUTPUT -s 192.0.0.0/24 -j DROP
iptables -A OUTPUT -s 192.0.2.0/24 -j DROP
iptables -A OUTPUT -s 198.18.0.0/15 -j DROP
iptables -A OUTPUT -s 198.51.100.0/24 -j DROP
iptables -A OUTPUT -s 203.0.113.0/24 -j DROP
iptables -A OUTPUT -s 224.0.0.0/3 -j DROP
iptables -A INPUT -d 127.0.0.0/8 -i $interface -j DROP
iptables -A INPUT -d 0.0.0.0/8 -j DROP
iptables -A INPUT -d 100.64.0.0/10 -j DROP
iptables -A INPUT -d 169.254.0.0/16 -j DROP
iptables -A INPUT -d 192.0.0.0/24 -j DROP
iptables -A INPUT -d 192.0.2.0/24 -j DROP
iptables -A INPUT -d 198.18.0.0/15 -j DROP
iptables -A INPUT -d 198.51.100.0/24 -j DROP
iptables -A INPUT -d 203.0.113.0/24 -j DROP
iptables -A INPUT -d 224.0.0.0/3 -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --match multiport --sports 1:1022 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --match multiport --sports 1:1022 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --match multiport --dports 1:1022 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp --match multiport --dports 1:1022 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -P OUTPUT DROP

#More Misch--Cron activities outputted to /var/local/cronjoblist --proccesses to /var/local/pslist
chmod 604 /etc/shadow
crontab -l >> /var/local/cronjoblist.log
ss -an4 > /var/local/netstat.log
ps axk start_time -o start_time,pid,user,cmd >> /var/local/pslist.log

#Installation and first run of ClamAV
apt-get install clamav -y
freshclam
clamscan -r /*

apt-get autoremove -y
apt-get autoclean -y
apt-get clean -y

reboot


#Order of Operations (Take notes throughout)
#1.Read readme
#2.answer forensics
#3.git clone https://github.com/Adamapb/...
#./<file name>
#4.Check scoring
#5.do user tasks (Perms, acct types, passwords, super users)
#6.Check output populated earlier in script (in comments)
#7.check scoring
#8.Review readme **CAREFULLY**
#9.View running services/daemons
#10.view active ports
#11.check system spec utilization
#12.check scoring
#13.review readme, double check update status on named applications
#14.If not 100, **brainstorm**, review config files, review running services