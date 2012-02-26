#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

package MovingCamel::Exception::RendererNotFound;

use strict;
use warnings;

use base qw(MovingCamel::Exception);

sub new {
   my $that = shift;
   my $proto = ref($that) || $that;
   my $self = { @_ };

   bless($self, $proto);

   $self->{'code'} = 50000;

   return $self;
}

1;
