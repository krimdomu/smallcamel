#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Handler::CGI;
   
use strict;
use warnings;

use MovingCamel::Base;
use MovingCamel::Handler;
use HTTP::Request;
use HTTP::Response;
use MovingCamel;

use CGI;
use base qw(MovingCamel::Handler);

has cgi => { is => 'r' };

sub _get_request_object {
   my ($self) = @_;

   if($self->{"__data"}->{req}) { return $self->{"__data"}->{req}; }

   my $req = HTTP::Request->new;
   $self->cgi(CGI->new);

   $req->method($ENV{REQUEST_METHOD});
   $req->uri($ENV{REQUEST_URI});

   for my $key (keys %ENV) {
      if($key =~ m/^HTTP_(.*)$/) {
         $req->header($1 => $ENV{$key});
      }
   }

   if($ENV{REQUEST_METHOD} ne "GET") {
      $req->content($self->cgi->param($ENV{REQUEST_METHOD}."DATA"));
   }

   $self->{"__data"}->{req} = $req;
}

sub _get_response_object {
   my ($self) = @_;

   if(! $self->{"__data"}->{res}) {
      $self->{"__data"}->{res} = HTTP::Response->new;
   }

   $self->{"__data"}->{res};

}

sub _submit {
   my ($self) = @_;

   my @payload = split(/\n/, $self->res->as_string);
   shift @payload;
   print join("\n", @payload);
}

sub _param {
   my ($self) = @_;

   $self->cgi->param($_[1]);
}

1;
