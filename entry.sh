#!/bin/bash
if [ ! -f /etc/cmdbuild_configured ]
then
    if [ -n "$DB_HOST" ]
    then
        if [ -n "$DB_PORT" ]
        then
            if [ -n "$DB_NAME" ]
            then
                echo "db.url=jdbc:postgresql://"$DB_HOST:$DB_PORT/$DB_NAME > /usr/local/tomcat/conf/cmdbuild/database.conf;              
            else
                echo "No Database name found, please provide it with -e DB_NAME=value. Exiting...";
                exit 1;
            fi
        else
            echo "No Database port found, please provide it with -e DB_PORT=value. Exiting...";
            exit 1;
        fi
    else
        echo "No Database host found, please provide it with -e DB_HOST=value. Exiting...";
        exit 1;
    fi


    if [ -n "$CMDBUILD_USERNAME" ] 
    then        
            if [ -n "$CMDBUILD_PASSWORD" ] 
            then
                echo "db.username="$CMDBUILD_USERNAME >> /usr/local/tomcat/conf/cmdbuild/database.conf;
                echo "db.password="$CMDBUILD_PASSWORD >> /usr/local/tomcat/conf/cmdbuild/database.conf;
            else  
                echo "No DB password found, please provide it with -e CMDBUILD_PASSWORD=value. Exiting...";
                exit 1;
            fi
    else
        echo "No DB username found, please provide it with -e CMDBUILD_USERNAME=value. Exiting...";
        exit 1;
    fi    

    if [ -n "$POSTGRES_USERNAME" ] 
    then        
            if [ -n "$POSTGRES_PASSWORD" ] 
            then
                echo "db.admin.username="$POSTGRES_USERNAME >> /usr/local/tomcat/conf/cmdbuild/database.conf;
                echo "db.admin.password="$POSTGRES_PASSWORD >> /usr/local/tomcat/conf/cmdbuild/database.conf;
            else  
                echo "No admin DB password found, 'postgres' will be used.";        
            fi
    else
        echo "No admin DB username found, 'postgres' will be used";
        echo "db.admin.username=postgres" >> /usr/local/tomcat/conf/cmdbuild/database.conf;
        echo "db.admin.password=postgres" >> /usr/local/tomcat/conf/cmdbuild/database.conf;  
        echo "Setting first time configuration as done... "
        touch /etc/cmdbuild_configured              
    fi          
fi

echo "Starting CMDBuild...";
su -m r -c "/usr/local/tomcat/bin/catalina.sh run"