package ManagerDB::Schema::Result::Order;
use Modern::Perl;
use experimental 'signatures';
use base 'DBIx::Class::Core';

use ManagerDB::Schema::Result::Customer;
__PACKAGE__->table('orders'); # !avoid order since SQL reserved keyword (could be escaped using [])
__PACKAGE__->add_columns(
     id => {
       data_type         => 'integer',
       is_auto_increment => 1
    },
   number => {
     data_type => 'text' # actually order "number" can be 2 numbers separated by a dash
   },
   date => {
     data_type => 'text' # no SQLite support, use ISO8601 format
   },
   customer_id =>{
    data_type => 'integer'
   }
    );

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint('number_unique' => ['number']); 
__PACKAGE__->belongs_to('customer', 'ManagerDB::Schema::Result::Customer', 'customer_id');