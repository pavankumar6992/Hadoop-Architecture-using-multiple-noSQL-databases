#!/bin/bash 


	echo -e "Starting Hadoop services"
        start-dfs.sh
		sleep 6s
    	start-yarn.sh
		sleep 6s
		start-hbase.sh
		sleep 6s
    	jps
    	
	echo -e"Hadoop service started"	
		
        wget https://www.dropbox.com/s/wuja65yb2mo769a/DelayedFlights.csv?dl=0  #dataset download
		location=$(locate DelayedFlights.csv) # finds the file 
    	hadoop fs -mkdir -p /project/flight # create dir in hdfs
    	hive -f Hive/CreateTable.hql	# create table flight_input3
		hive -S -e "use PDA;  show tables; "  #validating created table in hive 

	echo -e "**********************Flight Analysis Start***********************"
echo -e #Creating mysql database
echo "Please enter your MySql database details"
			read -p 'username: ' hive
			read -sp 'password: ' admin
			echo
			mysql -u $user -p"$password" -e 'create database if not exists PDA;use PDA;drop table if exists flight_input3;CREATE TABLE flight_input3(s_no integer,Year integer,Month LONGTEXT, DayofMonth integer, DayofWeek integer,DepTime integer, CRSDepTime integer, ArrTime integer, CRSArrTime integer,UniqueCarrier LONGTEXT, FlightNum integer, TailNum LONGTEXT, ActualElapsedTime integer,CRSElapsedTime integer, AirTime integer, ArrDelay integer, DepDelay integer,Origin LONGTEXT, Dest LONGTEXT, Distanceinteger, TaxiIn integer,TaxiOut integer, Cancelled integer, CancellationCode LONGTEXT);
			exit;'
			echo "sqoop import to hdfs"	
			sqoop import --connect jdbc:mysql://127.0.0.1/PDA --username hive --password admin --table flight_input3 --target-dir /flight_input3 -m 1;
			mysql -u $user -p"$password" -e 'use PDA;select * from flight_input3;'
		
			
			;;
		\n) exit;   
		;;
		*) clear;
		;;
        esac
fi
done 	






			
			

			