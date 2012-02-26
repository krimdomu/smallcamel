#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Base::Type::Int;
   
use strict;
use warnings;

use MovingCamel::Base::Type::Base;
use base qw(MovingCamel::Base::Type::Base);

sub check {
   my ($class, $val) = @_;
   if($val =~ m/^\d+$/) {
      return 1;
   }
}

1;
