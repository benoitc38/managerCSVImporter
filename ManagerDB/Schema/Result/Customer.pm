package ManagerDB::Schema::Result::Customer;
use Modern::Perl;
use experimental 'signatures';
use TryCatch;
use base 'DBIx::Class::Core';
sub toto {
  return "toto";
}
__PACKAGE__->table('customers');
__PACKAGE__->add_columns(
     id => {
       data_type         => 'integer',
       is_auto_increment => 1
    },
   first_name => {
     data_type => 'varchar',
     size      => 255,
     is_unique => 1
   },
   last_name => {
     data_type => 'varchar',
     size      => 255
   }
    );
__PACKAGE__->inflate_column('last_name', {
     inflate => sub { 
      return "toto"; },
     deflate => sub { 
      return "titi"; },
 });
__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint('first_last_name_unique' => [qw / first_name last_name /]); # doesn't work!
__PACKAGE__->inflate_column('first_name', {
     inflate => undef,
     deflate => sub { "toto"},
 });
# importFromCSV line as hash
sub loadFromCSVLineHash($self, $csv_line){
  # remove any irrelevant key from csv_line hash
  print($self->columns);
  try{
  #$self->create($csv_line);
  }catch($err){
    print("Error loadFromRawHash():",$err);
  }
}

1;