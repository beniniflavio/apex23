docker login container-registry.oracle.com

docker pull container-registry.oracle.com/database/enterprise:latest

docker run -d -it --name 23cfree -p 8521:1521 -p 8500:5500 -p 8023:8080 -p 9043:8443 -e ORACLE_PWD=E container-registry.oracle.com/database/free:latest

docker exec -it 23cfree /bin/bash

curl -o apex-latest.zip https://download.oracle.com/otn_software/apex/apex-latest.zip

unzip apex-latest.zip
rm apex-latest.zip
cd apex

sqlplus / as sysdba

ALTER SESSION SET CONTAINER = FREEPDB1;
@apexins.sql SYSAUX SYSAUX TEMP /i/

ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY E;

@apxchpwd.sql

exit


mkdir /home/oracle/software
mkdir /home/oracle/software/apex
mkdir /home/oracle/software/ords
mkdir /home/oracle/scripts

cp -r /home/oracle/apex/images /home/oracle/software/apex
cd /home/oracle/

dnf install nano -y

nano /etc/sudoers
Defaults !lecture
oracle ALL=(ALL) NOPASSWD: ALL

dnf install java-17-openjdk -y


mkdir /etc/ords
mkdir /etc/ords/config
mkdir /home/oracle/logs
chmod -R 777 /etc/ords
java -version


yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL8/oracle/software/x86_64
dnf install ords -y

export _JAVA_OPTIONS="-Xms512M -Xmx512M"
ords --config /etc/ords/config install

nano /home/oracle/scripts/start_ords.sh

nano /home/oracle/scripts/start_ords.sh

sh /home/oracle/scripts/start_ords.sh
sh /home/oracle/scripts/stop_ords.sh

docker update --restart unless-stopped $(docker ps -q)

nano /opt/oracle/scripts/startup/01_auto_ords.sh
