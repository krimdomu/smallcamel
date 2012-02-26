#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# surely not standard conform, but it works for me...
#
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:

=head1 NAME

MovingCamel::JSON - Encode and Decode JSON.

=head1 DESCRIPTION

Simple Class to encode and decode JSON.

=cut



package MovingCamel::JSON;

use strict;
use warnings;

use constant null  => 0;
use constant true  => 1;
use constant false => 0;

use utf8;


=head1 CONSTRUCTOR

=over 4

=item new
=cut
sub new {
   my $that = shift;
   my $proto = ref($that) || $that;
   my $self = { @_ };

   bless($self, $proto);

   return $self;
}

=back
=cut

=head1 METHODS

=over 4

=item encode($ref)

Encode Perl Reference (Hash, Array) to JSON. If $ref is an object it will use the TO_JSON method to convert the object to JSON.

=cut
sub encode {
   my $self = shift;
   my $ref = shift;
   my $s = "";

   if(ref($ref) eq "ARRAY") {
      $s .= '[';
      my $inner = '';
      for my $e (@{$ref}) {
         $inner .= ',' if $inner;
         $inner .= $self->encode($e);
      }
      $s .= $inner;
      $s .= ']';
   } elsif(ref($ref) eq "HASH") {
      $s .= '{';
      my $inner = '';
      for my $e (keys %{$ref}) {
         $inner .= ',' if $inner;
         $inner .= '"' . $e . '":';
         $inner .= $self->encode($ref->{$e});
      }
      $s .= $inner;
      $s .= '}';
   } elsif(! ref($ref)) {
      # normaler skalar
      if($ref =~ /^([+-]?)(?=\d|[\.]\d)\d*([\.]\d*)?([Ee]([+-]?\d+))?$/) {
         $s = $ref;
      } else {
         $s = '"' . $ref . '"';
      }
   } elsif($self->{'convert_blessed'} && ref($ref)) {
      eval {
         $s .= $self->encode($ref->TO_JSON);
      };
   }

   return $s;
}

=item decode($json)

Decode given json to Perl structure.

=cut
sub decode {
   my $self = shift;
   my $j = shift;
   my $open = 0;
   my $davor = "";
   my $json = "";
   for my $char (split(//, $j)) {
      if($char eq '"' && $davor ne "\\" && $open == 0) {
         $open = 1;
      } elsif($char eq '"' && $davor ne "\\" && $open == 1) {
         $open = 0;
      }

      if($open == 0 && $char eq ":") {
         $json .= '=>';
      } else {
         $json .= $char;
      }

      $davor = $char;
   }
   return eval $json;
}

=item convert_blessed($bool)

If set to 1 encode will also convert objects with a TO_JSON method.

=back
=cut
sub convert_blessed {
   my $self = shift;
   $self->{'convert_blessed'} = shift;
}

1;
