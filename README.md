Manager CSV import project (Jan 23)
===================================

Description:
============
The application relies on DBIx::Class modules.

Note: I bumped into a road block while trying to attempt to define my own routines to convert to/from database several fields. Thus, the CSV import contains some errors such as "John " and the date not
converted back to a date type after being fetched from the database.

Here are some of the tasks I intended to do after that troubleshooting the inflate/deflate issue but
that I didn't manage to complete:

- inflate/deflate : 
     to convert into and from SQL data to cope with data type limitations (Date as ISO string)
     normalize fields before writing into the database such as a regex to remove starting and ending separator characters
     "John "
- command line options to configure the CSV import (csv as input) to be exposed to manager
- check manager.db file existence to run deploy
- package the script and its depencies as a Debian one for manager installation
- installation+usage instructions as github readme vs embedded in package

