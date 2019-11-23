#!/bin/bash
TOMCAT_HOME=/usr/local/tomcat
if [ ! -f /etc/cmdbuild_configured ]
then
    if [ -n "$DB_HOST" ]
    then
        if [ -n "$DB_PORT" ]
        then
            if [ -n "$DB_NAME" ]
            then
                echo "db.url=jdbc:postgresql://"$DB_HOST:$DB_PORT/$DB_NAME > $TOMCAT_HOME/conf/cmdbuild/database.conf;              
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
            echo "db.username="$CMDBUILD_USERNAME >> $TOMCAT_HOME/conf/cmdbuild/database.conf;
            echo "db.password="$CMDBUILD_PASSWORD >> $TOMCAT_HOME/conf/cmdbuild/database.conf;
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
            echo "db.admin.username="$POSTGRES_USERNAME >> $TOMCAT_HOME/conf/cmdbuild/database.conf;
            echo "db.admin.password="$POSTGRES_PASSWORD >> $TOMCAT_HOME/conf/cmdbuild/database.conf;
        else  
            echo "No admin DB password found, 'postgres' will be used.";        
        fi
    else
        echo "No admin DB username found, 'postgres' will be used";
        echo "db.admin.username=postgres" >> $TOMCAT_HOME/conf/cmdbuild/database.conf;
        echo "db.admin.password=postgres" >> $TOMCAT_HOME/conf/cmdbuild/database.conf;  
        echo "Setting first time configuration as done... "
        touch /etc/cmdbuild_configured              
    fi 
    if [ -n "$DB_TYPE" ]
    then  
        case $DB_TYPE in 
            empty)
                echo "Empty database selected. Restoring..."
                bash $TOMCAT_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create -configfile $TOMCAT_HOME/conf/cmdbuild/database.conf $TOMCAT_HOME/webapps/WEB-INF/sql/dump/empty_30.dump.xz 
                echo "Restore complete. Starting Tomcat..."
                ;;
            demo)
                echo "Demo database selected. Restoring..."
                bash $TOMCAT_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create -configfile $TOMCAT_HOME/conf/cmdbuild/database.conf $TOMCAT_HOME/webapps/WEB-INF/sql/dump/demo.dump.xz                 
                echo "Restore complete. Starting Tomcat..."
                ;;
            ready2use)
                echo "CMDBuild Ready2use empty database selected. Restoring..."
                bash $TOMCAT_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create -configfile $TOMCAT_HOME/conf/cmdbuild/database.conf $TOMCAT_HOME/webapps/WEB-INF/sql/dump/ready2use_empty.dump.xz                 
                echo "Restore complete. Starting Tomcat..."
                ;;
            ready2use_demo)
                echo "CMDBuild Ready2use Demo database selected. Restoring..."
                bash $TOMCAT_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create -configfile $TOMCAT_HOME/conf/cmdbuild/database.conf $TOMCAT_HOME/webapps/WEB-INF/sql/dump/ready2use_demo.dump.xz                 
                echo "Restore complete. Starting Tomcat..."
                ;;            
            *)
                echo "Unknown db type selected. No db restore will be ran. Starting Tomcat..."
                ;;
        esac
    fi
fi

echo "Starting Tomcat..."
su -m r -c "/usr/local/tomcat/bin/catalina.sh run"