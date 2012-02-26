#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Renderer::TEXT;
   
use strict;
use warnings;

use MovingCamel::Base;

sub render {
   my ($class, $mvc, $vars) = @_;

   $mvc->tx->res->code(200);
   $mvc->tx->res->message("OK");
   $mvc->tx->res->header("Status" => 200);
   $mvc->tx->res->header("Content-Type" => "text/plain; charset=utf-8");

   $mvc->tx->res->content($vars);
}

1;
