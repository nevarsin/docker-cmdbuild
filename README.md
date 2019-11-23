# CMDBuild in a box
This is a Docker image for the Asset Management application CMDBuild.

The image is built against the latest official TomCat 8.5.x image from Apache Foundation.

## Database
CMDBuild supports only PostgreSQL (9.5 to 10.7) and it requires a connection where an pre-restored database structure is available.

For this, you will find several compressed SQL dumps available within the webapp folder:

`/usr/local/tomcat/webapps/WEB-INF/sql/dump/`

- empty (system structure, no data)
- demo (system structure, demo data)
- ready2use (CMDBuild Ready2Use 2.0 structure, no data)
- ready2use_demo (CMDBuild Ready2Use 2.x structure, demo data)

# How to Run

This image supports several parameters to be set as environment variables:
- DB_HOST (Required: PGSQL hostname)
- DB_PORT (Required: PGSQL port)
- DB_NAME (Required: PGSQL database name)
- DB_TYPE (Optional: pre restore one of the database dumps listed above)
- CMDBUILD_USERNAME (Required: db username)
- CMDBUILD_PASSWORD (Required: db user password)
- POSTGRES_USERNAME (Required: db admin username)
- POSTGRES_PASSWORD (Required: db admin password)

NOTE: PostgreSQL admin credentials are required in order to install the PostGIS PSQL extension required by the GIS Server (optional)

## Docker run Example

`docker run --name cmdbuild -p 8080:8080 -e DB_HOST=dbhostname.domain -e DB_PORT=5432 -e DB_NAME=cmdbuild -e DB_TYPE=ready2use_demo -e CMDBUILD_USERNAME=cmdbuild -e CMDBUILD_PASSWORD=password -e POSTGRES_USERNAME=postgres -e POSTGRES_PASSWORD=postgres trepz/cmdbuild:3.1.1`

**Docker-compose and Kubernetes deployment templates coming soon**

## Access
Once the container is running (the startup phase can take up to a minute, depending on your host) you can access it via a web browser:
- URL: http://yourhost:8080/cmdbuild (or any port you chose while starting)
- User: admin
- Pass: admin

# Requirements
The following information is taken from the official [CMDBuild Sourceforce page](https://sourceforge.net/projects/cmdbuild/files/3.1.1/)

### Hardware requirements:

* server-class computer (modern architecture)
* 8 GB of RAM (16 GB for application with full functionalities eg. DMS,
map services, BIM services)
* 120 GB of available disk space for each CMDBuild instance


### Software requirements: 

* any OS able to handle the following applications (Linux recommended)
* PostgreSQL from 9.5 to 10.7
* PostGIS 2.4 or 2.5 (optional)
* Apache Tomcat 8.5.x
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

# Information and support

For support on this image building process and configuration please open an issue on the [docker-cmdbuild github repo](https://github.com/nevarsin/docker-cmdbuild/issues)

For every support need on the application itself please refer to the official websites:
- [CMDBuild](https://www.cmdbuild.org)
- [CMDBuild Ready2Use](https://www.cmdbuildready2use.org)

# CMDBuild license
Copyright Tecnoteca Srl 2005-2019

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License version 3
as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License 
along with this program.
If not, see <http://www.gnu.org/licenses/agpl.html>.

Project website: [http://www.cmdbuild.org](http://www.cmdbuild.org/)

Maintainer: Tecnoteca - [http://www.tecnoteca.com](http://www.tecnoteca.com)
