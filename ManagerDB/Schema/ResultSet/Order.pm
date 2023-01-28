package ManagerDB::Schema::ResultSet::Order;

use Modern::Perl;
use experimental 'signatures';
use TryCatch;
use Data::Dumper;

use base 'DBIx::Class::ResultSet';

# importFromCSV line as hash
# input: csv_line as hash ref
sub loadFromCSVLineHash($self, $csv_line){
  # remove any irrelevant key from csv_line hash
  print(Dumper($self->result_source->columns));
  my $singular_table_name=$self->result_source->name;
  chop($singular_table_name); # table singular to match CSV headers
  my @cols=map($singular_table_name." ".$_,$self->result_source->columns); 
  #my @arr=$self->result_source->columns;
  my %filtered_csv_line=%{$csv_line}{@cols};
  # now remove the key table name prefix if any
  my %no_prefix_csv_line;
  foreach my $key (keys %filtered_csv_line){
    my @parts=split(' ',$key); # keep the non-table header part
    if (@parts>1){
      $no_prefix_csv_line{$parts[1]}=$filtered_csv_line{$key};
    }
  }
  # remove primary key auto-increment column ? or replace it by null
  print(Dumper(%no_prefix_csv_line));
  try{
    $self->create(\%no_prefix_csv_line);
  }catch($err){
    print("Error loadFromRawHash():",$err);
  }
}

1;
