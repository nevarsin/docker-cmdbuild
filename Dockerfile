FROM tomcat:8.5.46-jdk8

#Ports
EXPOSE 8080/tcp

#Copy conf and libs
WORKDIR /usr/local/tomcat
COPY conf/database.conf conf/cmdbuild/
COPY lib/* lib/
COPY conf/tomcat-users.xml conf/
RUN rm -rf webapps/*

#Copy CMDBuild war file
COPY cmdbuild.war webapps/cmdbuild/
WORKDIR /usr/local/tomcat/webapps/cmdbuild
RUN jar -xvf cmdbuild.war

#Creating user as CMDBuild won't start when Tomcat is ran as root
RUN adduser --disabled-password --gecos '' r
RUN adduser r sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R r:r /usr/local/tomcat

#Copy init script 
COPY entry.sh /root/

#Run
CMD ["/bin/bash", "/root/entry.sh"]

