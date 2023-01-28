package ManagerDB::Schema::Result::Order;
use Modern::Perl;
use experimental 'signatures';
use base 'DBIx::Class::Core';

__PACKAGE__->table('orders');
__PACKAGE__->add_columns(
     id => {
       data_type         => 'integer',
       is_auto_increment => 1
    },
   number => {
     data_type => 'integer'
   },
   date => {
     data_type => 'text' # no SQLite support, use ISO8601 format
   },
    );

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint('number_unique' => ['number']); # doesn't work!