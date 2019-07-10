FROM tomcat:8.5.42-jdk8

#Ports
EXPOSE 8080/tcp

#Copy conf and libs
WORKDIR /usr/local/tomcat
COPY conf/database.conf conf/cmdbuild/
COPY lib/* lib/

#Copy CMDBuild war file
COPY cmdbuild-3.1-rc4_2019_07_09_18_01.war webapps/cmdbuild/
WORKDIR /usr/local/tomcat/webapps/cmdbuild
RUN jar -xvf cmdbuild-3.1-rc4_2019_07_09_18_01.war

#Creating user as CMDBuild won't start when Tomcat is ran as root
RUN adduser --disabled-password --gecos '' r
RUN adduser r sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R r:r /usr/local/tomcat

#Copy init script 
COPY entry.sh /root/
COPY conf/tomcat-users.xml /usr/local/tomcat/conf/

#Run
CMD ["/bin/bash", "/root/entry.sh"]

