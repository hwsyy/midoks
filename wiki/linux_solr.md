### solr�(linux)

### ��Ҫ����Դ
- yum -y remove java-1.7.0-openjdk*
- yum -y remove tzdata-java.noarch

- yum install java
- http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz ����Ҫ�ֶ����أ�
- wget http://mirror.bit.edu.cn/apache/lucene/solr/6.0.0/solr-6.0.0.tgz
- wget http://apache.opencas.org/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz


http://archive.apache.org/dist/lucene/solr/4.3.0/




### 

mv java* /usr/local/java





����java JDK
```
JAVA_HOME=/usr/local/java
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME PATH
```
д��:
/etc/profile.d/jdk.sh
ִ��,��Ч
./etc/profile.d/jdk.sh 

tar zxvf tomcat-*.tar.gz 
&& mv tomcat /usr/local/tomcat 
&& /usr/local/tomcat/bin/startup.sh












### ����

# uname -a # �鿴�ں�/����ϵͳ/CPU��Ϣ 
# head -n 1 /etc/issue # �鿴����ϵͳ�汾 
# cat /proc/cpuinfo # �鿴CPU��Ϣ 
# hostname # �鿴������� 
# lspci -tv # �г�����PCI�豸 
# lsusb -tv # �г�����USB�豸 
# lsmod # �г����ص��ں�ģ�� 
# env # �鿴����������Դ 
# free -m # �鿴�ڴ�ʹ�����ͽ�����ʹ���� 
# df -h # �鿴������ʹ����� 
# du -sh <Ŀ¼��> # �鿴ָ��Ŀ¼�Ĵ�С 
# grep MemTotal /proc/meminfo # �鿴�ڴ����� 
# grep MemFree /proc/meminfo # �鿴�����ڴ��� 
# uptime # �鿴ϵͳ����ʱ�䡢�û��������� 
# cat /proc/loadavg # �鿴ϵͳ���ش��̺ͷ��� 
# mount | column -t # �鿴�ҽӵķ���״̬ 
# fdisk -l # �鿴���з��� 
# swapon -s # �鿴���н������� 
# hdparm -i /dev/hda # �鿴���̲���(��������IDE�豸) 
# dmesg | grep IDE # �鿴����ʱIDE�豸���״������ 
# ifconfig # �鿴��������ӿڵ����� 
# iptables -L # �鿴����ǽ���� 
# route -n # �鿴·�ɱ� 
# netstat -lntp # �鿴���м����˿� 
# netstat -antp # �鿴�����Ѿ����������� 
# netstat -s # �鿴����ͳ����Ϣ���� 
# ps -ef # �鿴���н��� 
# top # ʵʱ��ʾ����״̬�û� 
# w # �鿴��û� 
# id <�û���> # �鿴ָ���û���Ϣ 
# last # �鿴�û���¼��־ 
# cut -d: -f1 /etc/passwd # �鿴ϵͳ�����û� 
# cut -d: -f1 /etc/group # �鿴ϵͳ������ 
# crontab -l # �鿴��ǰ�û��ļƻ�������� 
# chkconfig �Clist # �г�����ϵͳ���� 
# chkconfig �Clist | grep on # �г�����������ϵͳ������� 
# rpm -qa # �鿴���а�װ�������