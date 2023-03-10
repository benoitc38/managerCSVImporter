package ManagerDB::Schema::ResultSet::Item;

use Modern::Perl;
use experimental 'signatures';
use TryCatch;
use Data::Dumper;

use base 'DBIx::Class::ResultSet';

# importFromCSV line as hash
# input: csv_line as hash ref
sub loadFromCSVLine($self, $csv_line){
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
    if (defined($filtered_csv_line{$key})){
     $filtered_csv_line{$key} =~ s/\$//g; # remove price unit
     $filtered_csv_line{$key} =~ s/\.(\d?\d?)/$1/g; # remove dot
    }
    my @parts=split(' ',$key); # keep the non-table header part
    if (@parts>1){
      $no_prefix_csv_line{$parts[1]}=$filtered_csv_line{$key};
    }
  }
  # remove primary key auto-increment column ? or replace it by null
  $no_prefix_csv_line{'order'}={'number'=>${$csv_line}{'order number'}}; # specific related unique key
  print(Dumper(%no_prefix_csv_line));
  try{
    $self->find_or_create(\%no_prefix_csv_line);
  }catch($err){
    print("Error loadFromCSVLine():",$err);
  }
}

1;
