#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Base;
   
use utf8;
use strict;
use warnings;

require MovingCamel::Exporter;

use MovingCamel::Base::Type::Int;
use MovingCamel::Base::Type::String;

use MovingCamel::Exception::WrongValue;
use MovingCamel::Exception::TypeNotFound;
use MovingCamel::Exception::ReadOnly;

our @EXPORT = qw(new has);

sub new {
   my $that = shift;
   my $proto = ref($that) || $that;
   my $self = { @_ };

   bless($self, $proto);

   $self->{"__data"} = {};

   return $self;
}

sub has {
   my ($attr, $option) = @_;
   my ($package, $filename, $line) = caller;

no strict "refs";
   *{ "${package}::${attr}" } = sub {
      my ($self, $val) = @_;

      if(ref $option eq "CODE") {
         return &$option(@_);
      }

      if(defined $val) {
         if(exists $option->{isa}) {
            my $type = "MovingCamel::Base::Type::" . $option->{isa};
            eval "use $type;";
            if($@) {
               die(MovingCamel::Exception::TypeNotFound->new(message => "$type not found."));
            }

            if(! $type->check($val)) {
               die(MovingCamel::Exception::WrongValue->new(message => "$val is not a " . $option->{isa}));
            }
         }

         if(exists $option->{is} && $option->{is} eq "r" && exists $self->{"__data"}->{$attr}) {
            die(MovingCamel::Exception::ReadOnly->new(message => "$attr is only readonly."));
         }

         $self->{"__data"}->{$attr} = $val;
      }
      else {
         return $self->{"__data"}->{$attr};
      }
   };
use strict;

}


sub import {
   goto &MovingCamel::Exporter::import;
   utf8->import;
}

1;
