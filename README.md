# CMDBuild in a box
This is a Docker image for the Asset Management application CMDBuild.

The image is built against the latest official TomCat 8.5.x image from Apache Foundation.

### How to run
CMDBuild requires a PostgreSQL connection where an pre-restored database structure needs to be available.

You will find several SQL dumps available within the webapp folder:

`/usr/local


Given that, you will need to manually In order to set this up you will 


### Hardware requirements:

* server-class computer (modern architecture)
* 8 GB of RAM (1asd6 GB for application with full functionalities eg. DMS,
map services, BIM services)
* 120 GB of available hard disk space for each CMDBuild instance


### Software requirements: 

* any OS able to handle the following applications (linux recommended)
* PostgreSQL from 9.5 to 10.7
* PostGIS 2.4 or 2.5 (optional)
* Apache Tomcat 8.5 (8.5.34 recommended)
* JDK 1.8
* Any DMS that supports the CMIS protocol (Alfresco Community recommended, optional)
* Geoserver 2.10.1 (optional)
* BIMServer 1.5.138 (optional)


### Included libraries:

* jdbc library for DB connection
* jasperreports libraries for report generation
* shark libraries for the workflow engine (necessary only if you do not use default Tecnoteca RIVER workflow engine)
* CMIS DMS client
* Ext JS libraries for user interface
* Server and client components for map making feature
* Server and client components for BIM viewer


### Additional software that you may find useful (not included):

* JasperSoft Studio for custom report design
* Together Workflow Editor for custom workflow design
* OCS Inventory as automatic inventory software

