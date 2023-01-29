package ManagerDB::Schema::Result::Item;
use Modern::Perl;
use base 'DBIx::Class::Core';


__PACKAGE__->table('items');
__PACKAGE__->add_columns(
     id => {
       data_type         => 'integer',
       is_auto_increment => 1
    },
   name => {
     data_type => 'text'
   },
   manufacturer => {      # to be discussed, cleaner to be normalized into a manufacturer table?
     data_type => 'text'
   },
   price => {
     data_type => 'integer' # stored in cents (avoid floating ops: cost + precision)
   },
   order_id =>{
     data_type => 'integer' # foreign key
   }
    );

__PACKAGE__->set_primary_key('id');

# to make import idempotent (otherwise reimporting CSV file multiple time add new items!)
# => unique key for Item created, however these 3 keys are likely not sufficient=> to be discussed!
__PACKAGE__->add_unique_constraint('number_unique' => [qw/ order_id name manufacturer price /]); 
__PACKAGE__->belongs_to('order', 'ManagerDB::Schema::Result::Order', 'order_id');