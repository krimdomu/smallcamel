#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Server::FCGI;
   
use strict;
use warnings;

use FCGI;

use MovingCamel;
use MovingCamel::Base;
use MovingCamel::Handler::CGI;

sub run {
   my ($self, $urls) = @_;

   my $request = FCGI::Request();
   while($request->Accept() >= 0) {
      my $handler = MovingCamel::Handler::CGI->new;
      MovingCamel->dispatch($urls, $handler);
   }
}


1;
