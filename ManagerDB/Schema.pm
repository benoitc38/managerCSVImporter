package ManagerDB::Schema;
use Modern::Perl;
use experimental 'signatures';
use Text::CSV qw( csv );
use Data::Dumper;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces();


sub importCSVFile($self, $file_path, $tables){
    my $aoh = csv (in => $file_path, headers => "auto");   # as array of hash refs
    $aoh=[@$aoh[1..1]]; # Just for unit test
    foreach my $line (@$aoh){
        print(Dumper(%$line));
        #ManagerDB::Schema::ResultSet::Customer->loadFromCSVLineHash($line);
        #print(%$self->source_registrations);
        #$self->importIntoTable($self->source_registrations->{'Customer'});
        for my $table (@$tables){
            $table->loadFromCSVLine($line);
        }
        
=pod
        foreach my $table ($self->source_registrations){
            $table->importFromNameValues($line);
        }
=cut
    }
}

sub importIntoTable($self,$table){
print("importIntoTable()");
}

1;