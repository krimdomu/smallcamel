#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel;
   
use strict;
use warnings;

use MovingCamel::Base;
use Data::Dumper;

our $VERSION = "0.0.1";

has tx => { is => 'r' };

sub run {
   my ($self, $urls) = @_;

   # add default route
   $urls->{qr{^/([^/]+)/([^/\?]+)(\?.*)?$}} = '\1::\2';

   my $handler_class = "MovingCamel::Server::CGI";

   if(! exists $ENV{PATH}) {
      $handler_class = "MovingCamel::Server::FCGI";
   }
   elsif(exists $ENV{PATH} && ! exists $ENV{REQUEST_URI}) {
      $handler_class = "MovingCamel::Server::Simple";
   }
   elsif(exists $ENV{GATEWAY_INTERFACE} && $ENV{GATEWAY_INTERFACE} eq "CGI/1.1") {
      $handler_class = "MovingCamel::Server::CGI";
   }

   eval "use $handler_class;";

   my $handler = $handler_class->new;
   $handler->run($urls);
   
};

sub dispatch {

   my ($self, $urls, $tx) = @_;

   if(! ref($self) ) {
      my $t = $self->new;
      $t->dispatch($urls, $tx);

      return $t;
   }

   $self->tx($tx);

   # url dispatchen
   my ($url) = split(/\?/, $self->tx->req->uri);

   my $route;
   for my $regex (keys %{ $urls }) {
      if(my @matches = ($url =~ qr{^$regex$}) ) {
         for (my $i=0; $i <= $#matches; $i++) {
            next if ! $matches[$i];
            my $f = $i+1;
            $urls->{$regex} =~ s/\\$f/$matches[$i]/g;
         }
         $route = $urls->{$regex};
         last;
      }
   }

   # check if the route matches a method
   
   my ($perhaps_class, $perhaps_method);

   if($route && $route =~ m/::/) {
      if( my $func_ref = eval { $route->can($self->tx->req->method); } ) {
         $perhaps_class = $route;
         $perhaps_method = $self->tx->req->method;
      }
      else {
         ($perhaps_class, $perhaps_method) = ($route =~ m/^(.*)::(.*?)$/) if $route =~ m/::/;
      }
   }
   elsif($route) {
      $perhaps_class = $route;
   }

   $perhaps_method ||= $self->tx->req->method;

   if($perhaps_class 
      && $perhaps_method 
      && ( my $func_ref = eval { $perhaps_class->can($perhaps_method) } )) {
      my $ctrl = $perhaps_class->new(mvc => $self);
      $ctrl->$perhaps_method();
   }
   else {
      # no route found, dispatch to error 404 page
      $self->tx->res->code(404);
      $self->tx->res->message("Not found");
      $self->tx->res->header("Status" => 404);
      $self->tx->res->header("Content-Type" => "text/html");
      $self->tx->res->content("<html><body>Page not found.</body></html>");

      $self->tx->submit();

      return;
   }

   $self->tx->submit();

}

1;
