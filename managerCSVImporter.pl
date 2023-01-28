=head1
Good tutos:
https://github.com/castaway/dbix-class-book/blob/master/chapters/03-Describing-database.md
https://perlmaven.com/counter-with-database-backend-using-dbix-class

Very similar example to learn from:
- including readme.md with perldoc section (automatically extracted from source file?):
NAME
VERSION
SYNOPSIS
DESCRIPTION
METHODS
OPTIONS
RATIONALE
TODO
- command line options to configure the CSV import to be expose to manager
- installation+usage instructions as github readme (SaaS) vs embedded in package

SaaS version if time permits !!! constraint db in online:
- API Use catalyst framework to expose API 
- Basic react UI with unique form and file selector
- no installation doc
- online usage instructions
- swagger doc to document API
https://github.com/rwstauner/App-csv2sqlite
=cut
use experimental qw(signatures);
use Modern::Perl;
use experimental 'signatures'; 
#use feature qw(try);
use TryCatch; # try natively supported from 5.34 on, running 5.32 on RHEL 9.1

use ManagerDB::Schema;
use constant CSV_EXT         => '.csv';
use constant SQLITE_EXT      => '.db';

my $project_name="manager"; # default value
# TO DO get options --csv_file_path  --sqlite3_db_file_path
my $csv_file_path=$project_name.CSV_EXT;
my $sqlite3_db_file_path=$project_name.SQLITE_EXT;
my $schema = ManagerDB::Schema->connect("dbi:SQLite:${sqlite3_db_file_path}");
# TO DO if file exists
$schema->deploy();


$schema->importCSVFile($csv_file_path,[$schema->resultset('Customer'),$schema->resultset('Order'),$schema->resultset('Item')]);
print("End");