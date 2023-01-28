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
   manufacturer => {      # To be discussed, cleaner to be normalized into a manufacturer table?
     data_type => 'text'
   },
   price => {
     data_type => 'integer' # stored in cents (avoid floating ops: cost + precision)
   },
    );

__PACKAGE__->set_primary_key('id');