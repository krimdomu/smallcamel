#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Renderer::JSON;
   
use strict;
use warnings;

use MovingCamel::Base;
use MovingCamel::JSON;

sub render {
   my ($class, $mvc, $vars) = @_;

   $mvc->tx->res->code(200);
   $mvc->tx->res->message("OK");
   $mvc->tx->res->header("Status" => 200);
   $mvc->tx->res->header("Content-Type" => "application/json; charset=utf-8");

   my $json = MovingCamel::JSON->new;
   $json->convert_blessed(1);

   $mvc->tx->res->content($json->encode($vars));
}

1;
