#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Handler;
   
use strict;
use warnings;

use MovingCamel::Base;

has req => sub { shift->_get_request_object; };
has res => sub { shift->_get_response_object; };

has submit => sub { shift->_submit; };

has param => sub { shift->_param(@_); };

1;
