asqlmap - Automated sqlmap
=======

Asqlmap is a terminal interface to automatize the famous SQL Injection's tool [sqlmap](https://github.com/sqlmapproject/sqlmap).
It provides a very simple interface to quickly perform sqlmap's tests on a specific target.

This version of asqlmap was tested on [Parrot Security](https://www.parrotsec.org/).

<p align="center"><img src="https://raw.githubusercontent.com/Gualty/asqlmap/master/screenshot.png" width="50%" height="50%"></p>

**Asqlmap** is very simple to use: you only need to specify the target. Then you can choose which test you want to perform.

**asqlmap options**
---------

-	Vulnerability check and information research (Databases,tables)
-	Users, passwords and privileges research
-	Open SQL Shell
-	Open OS Shell
-	Dump single table (CSV)
- 	Dump single table (HTML)
-	Dump single database (CSV)
-	Dump single database (HTML)
-	Dump all databases (CSV)
-	Dump all databases (HTML)
-	Retrieve everything (CSV) - can take a long time!
-	Retrieve everything (HTML) - can take a long time!


***asqlmap*** is pre-configured to keeps your anonymity safe using Tor for every operation and using a random User Agent for each test.


What is sqlmap?
-------

sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers. It comes with a powerful detection engine, many niche features for the ultimate penetration tester, and a broad range of switches including database fingerprinting, over data fetching from the database, accessing the underlying file system, and executing commands on the operating system via out-of-band connections.

For further information about sqlmap visit their github webpage: https://github.com/sqlmapproject/sqlmap

Requirements:
-------

- sqlmap
- Tor (Start Tor on all the system before running asqlmap)


How to use asqlmap
-------

Before you can run asqlmap you need to set execution permission

chmod +x asqlmap.sh

Test an URL
-------

USAGE:

	./asqlmap.sh "URL" [OPTIONS]
	
Options after URL:

	-r <risk value>		Risk of test to perform (0-3, default 1)
	
	-l <level value>	Level of test to perform (1-5, default 1)
	
	-t <# of threads>   	Number of threads (1-10, default 1)
	
Options without URL:

	-g <google dork>	Search for Google Dorks
	
	-purge-output		Securely erase the sqlmap output directory
	
	-h,-help		Show this help
	
	-v			Show the version of asqlmap
	

```Eg. ./asqlmap.sh "http://www.example.com" -r 2 -l 3```

NOTE: Don't forget to add " at the beginning and at the end of the URL to support more than one GET variables.

See sqlmap documentation to understand risk (https://github.com/sqlmapproject/sqlmap/wiki/Usage#risk) and level (https://github.com/sqlmapproject/sqlmap/wiki/Usage#level) options

Search URL with Google Dork
-------

```./asqlmap.sh -g GOOGLEDORK

Eg. ./asqlmap.sh -g "inurl:index.php?id="

To scan a website for Google Dork

Eg. ./asqlmap.sh -g "site:http://www.example.com ext:php"
```

Know issues
-------

None at the moment
