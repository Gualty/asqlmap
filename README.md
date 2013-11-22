asqlmap - Automated sqlmap for BackBox
=======

Asqlmap is a terminal interface to automatize the famous SQL Injection's tool sqlmap.
It provides a very simple interface to quickly perform sqlmap's tests on a specific target.

This version of asqlmap was tested on BackBox Linux.

Asqlmap is very simple to use: you only need to specify the target. Then from the interface you can choose which test you want to perform.

With asqlmap you can:

1) Vulnerability check and information research (Databases,tables)

2) Users, passwords and privileges research

3) Open SQL Shell

4) Open OS Shell

5) Dump single table

6) Dump single database

7) Dump all databases


Asqlmap is pre-configured to keeps your anonymity safe using Tor for every operation and using a random User Agent for each test.


What is sqlmap?
-------

sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers. It comes with a powerful detection engine, many niche features for the ultimate penetration tester and a broad range of switches lasting from database fingerprinting, over data fetching from the database, to accessing the underlying file system and executing commands on the operating system via out-of-band connections.

For further information about sqlmap visit their github webpage: https://github.com/sqlmapproject/sqlmap

How to use asqlmap
-------

Before you can run asqlmap you need to set execution permission

chmod +x asqlmap.sh

Test an URL
-------

./asqlmap.sh "URL"

Eg. ./asqlmap.sh "http://www.example.com"

NOTE: Don't forget to add " at the beginning and at the end of the URL to support more than one GET variables.

Search URL with Google Dork
-------

./asqlmap.sh -g GOOGLEDORK

Eg. ./asqlmap.sh -g inurl:index.php?id=

Know issues
-------

None at the moment
