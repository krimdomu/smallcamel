#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Server::CGI;
   
use strict;
use warnings;

use MovingCamel;
use MovingCamel::Base;
use MovingCamel::Handler::CGI;

sub run {
   my ($self, $urls) = @_;

   my $handler = MovingCamel::Handler::CGI->new;
   MovingCamel->dispatch($urls, $handler);
}


1;
