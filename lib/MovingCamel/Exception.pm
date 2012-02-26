#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Exception;

use strict;
use warnings;


sub new {
   my $that = shift;
   my $proto = ref($that) || $that;
   my $self = { @_ };

   bless($self, $proto);

   return $self;
}

sub message {
   my $self = shift;
   return $self->{'message'} || 'Unknown Error';
}

sub code {
   my $self = shift;
   return $self->{'code'} || 0;
}

sub get_trace {
   require Devel::StackTrace;
   return split(/\n/, "".Devel::StackTrace->new);
}

1;
