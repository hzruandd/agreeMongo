#Install Java and Maven


# install via yum/apt-get
sudo yum install java-devel

#Download MVN from http://maven.apache.org/download.cgi

wget http://ftp.heanet.ie/mirrors/www.apache.org/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
sudo tar xzf apache-maven-*-bin.tar.gz -C /usr/local
cd /usr/local
sudo ln -s apache-maven-* maven
sudo vi /etc/profile.d/maven.sh

#Add the following to maven.sh
export M2_HOME=/usr/local/maven
export PATH=${M2_HOME}/bin:${PATH}

#Reload bash and test mvn
bash
mvn -version

