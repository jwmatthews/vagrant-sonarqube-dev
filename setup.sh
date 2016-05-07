#!/bin/sh

INSTALL_DIR="/home/vagrant"
SONARQUBE_VER="sonarqube-5.5"

yum -y install epel-release
yum -y install postgresql-server postgresql-contrib postgresql-devel
yum -y install java-1.8.0-openjdk-devel
yum -y install unzip

postgresql-setup initdb
cp /vagrant/provision/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
systemctl start postgresql
systemctl enable postgresql

#sudo -u "postgres" createdb test
#sudo -u "postgres" psql -c "CREATE ROLE testuser WITH SUPERUSER LOGIN PASSWORD 'test';"

sudo -u "postgres" psql -c "create user sonar;"
sudo -u "postgres" psql -c "alter role sonar with createdb;"
sudo -u "postgres" psql -c "alter user sonar with encrypted password 'sonar';"
sudo -u "postgres" psql -c "create database sonar owner sonar;"
sudo -u "postgres" psql -c "grant all privileges on database sonar to sonar;"


pushd .
cd ${INSTALL_DIR}
wget -q https://sonarsource.bintray.com/Distribution/sonarqube/${SONARQUBE_VER}.zip
unzip -qq ${SONARQUBE_VER}.zip

wget -q https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.zip
unzip -qq sonar-scanner-2.6.zip

wget -q https://github.com/SonarSource/sonar-examples/archive/master.zip
unzip -qq master.zip
cd ..

cp /vagrant/provision/sonar.properties ${INSTALL_DIR}/${SONARQUBE_VER}/conf/sonar.properties
sudo chown -R vagrant:vagrant ${INSTALL_DIR}
popd
