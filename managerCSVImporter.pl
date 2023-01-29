=head1
TODO
- inflate/deflate : 
     to convert into and from SQL data to cope with data type limitations (Date as ISO string)
     normalize fields before writing into the database such as a regex to remove starting and ending separator characters
     "John "
- command line options to configure the CSV import (csv as input) to be exposed to manager
- check manager.db file existence to run deploy
- package the script and its depencies as a Debian one for manager installation
- installation+usage instructions as github readme vs embedded in package

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