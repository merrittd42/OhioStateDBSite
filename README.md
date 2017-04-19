# OhioStateDBSite
A quick Sinatra site to score some sweet, sweet extra credit in the world's most enthralling databases course.

## Prerequisites
You'll need to have Microsoft SQL Server installed on your computer. Gem dependencies are Sinatra and Tiny_TDS.
You're also gonna need FreeTDS if you run Linux like a cool kid. Use these commands:
`wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz`

`tar -xzf freetds-1.00.27.tar.gz`

`cd freetds-1.00.27`

`./configure --prefix=/usr/local --with-tdsver=7.3`

`make`

`make install`

## Running The Program
Within the OhioStateDBSite directory, run `ruby datahelper.rb`. Make sure you have a local Microsoft SQL Server to connect to as well.
You can change the SQL server settings in the code, I made this in 2 days. Sue me, I don't care. You use git. You know.
## Acknowledgements

### Dillon Merritt

* Basically Made The Whole WebApp
* Wrote some of those nifty table creation and insert SQL statements
* Everything you see, AND MORE on GitHub.

### Tom Haight

* Did a whole lot of database stuff.
* Had Microsoft SQL Server installed on his computer before anyone else was able to.
* Presented the native DB updates on his laptop, something my Trusty Ubuntu Chromebook could NEVER do (please crouton add support).

### Jack Schroder

* Also did a whole lot of database stuff.
* Organized the team a lot, very nice.

### Yusuf Farah

* Did a whole ton of SQL statements.
