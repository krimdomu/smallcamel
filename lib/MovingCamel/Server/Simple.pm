#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Server::Simple;
   
use strict;
use warnings;

use Net::Server::HTTP;
use MovingCamel;
use MovingCamel::Handler::CGI;

use base qw(Net::Server::HTTP);

sub run {
   my ($self, $urls) = @_;

   $self->{urls} = $urls;

   $self->SUPER::run(
      port => 3000,
   );
}

sub process_http_request {
   my ($self) = @_;

   my $handler = MovingCamel::Handler::CGI->new;
   MovingCamel->dispatch($self->{urls}, $handler);
}


1;
