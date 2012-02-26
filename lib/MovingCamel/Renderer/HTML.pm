#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Renderer::HTML;
   
use strict;
use warnings;

use MovingCamel::Base;
use MovingCamel::Template;

sub render {
   my ($self, $mvc, $content, $vars) = @_;

   my $t = MovingCamel::Template->new;

   my $parsed = $t->parse($content, $vars);

   $mvc->tx->res->code(200);
   $mvc->tx->res->message("OK");
   $mvc->tx->res->header("Status" => 200);
   $mvc->tx->res->header("Content-Type" => "text/html; charset=utf-8");
   $mvc->tx->res->content($parsed);

}

1;
