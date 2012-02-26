#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Base::Type::Base;
   
use strict;
use warnings;

sub check {
   my ($class, $val) = @_;
   if(defined $val) { return 1; }
}

1;
