FROM tomcat:8.5.46-jdk8

#Ports
EXPOSE 8080/tcp

#Psql libs
RUN apt-get update && apt-get install -y libpq5 && rm -rf /var/lib/apt/lists/*

#Copy conf and libs
WORKDIR /usr/local/tomcat
COPY conf/database.conf conf/cmdbuild/
COPY lib/* lib/
COPY conf/tomcat-users.xml conf/
RUN rm -rf webapps/*

#Copy CMDBuild war file
RUN wget https://sourceforge.net/projects/cmdbuild/files/3.1.1/cmdbuild-3.1.1.war/download -O webapps/cmdbuild/cmdbuild.war
WORKDIR /usr/local/tomcat/webapps/cmdbuild
RUN jar -xvf cmdbuild.war && rm -rf cmdbuild.war

#Creating user as CMDBuild won't start when Tomcat is ran as root
RUN adduser --disabled-password --gecos '' r && adduser r sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R r:r /usr/local/tomcat

#Copy init script 
COPY entry.sh /root/

#Run
CMD ["/bin/bash", "/root/entry.sh"]

