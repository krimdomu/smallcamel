#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package MovingCamel::Controller;
   
use strict;
use warnings;

use MovingCamel::Base;
use MovingCamel::Exception::RendererNotFound;

has param => sub { shift->tx->_param(@_); };
has tx => sub { shift->{mvc}->tx; };

sub render {
   my ($self, $type, $vars, $vars2) = @_;

   if(ref $type) { $vars = $type; $type = "-template"; }

   if($type eq "-template") {

      if($vars =~ m/^\@(.*)$/) {
         my ($class, $file, $line) = caller;
         $vars = $self->_read_data($file, $1);
      }
      else {
         $vars = eval { local(@ARGV, $/) = ($vars); <>;};
      }
      $type = "-html"; 
   }

   my $render_class = "MovingCamel::Renderer::" . uc(substr($type, 1));

   eval "use $render_class;";

   if($@) { die MovingCamel::Exception::RendererNotFound->new; }

   $render_class->render($self->{mvc}, $vars, $vars2);
}

sub redirect {
   my ($self, %option) = @_;

   $self->tx->res->code($option{"-code"} || 301);
   $self->tx->res->message($option{"-message"} || "Moved");
   $self->tx->res->header("Status" => $option{"-code"} || 301);
   $self->tx->res->header("Location" => $option{"-to"});
   $self->tx->res->header("Content-Type" => "text/html; charset=utf-8");
   $self->tx->res->content("Moved to " . $option{"-to"});
}

sub _read_data {
   my ($self, $file, $section) = @_;

   my $content = "";
   my $in_sec = 0;
   open(my $fh, "<", $file) or die($!);
   while(my $line = <$fh>) {
      chomp $line;
      if($line =~ m/^\@$section$/) {
         $in_sec = 1;
         next;
      }

      if($line =~ m/^\@end$/) {
         $in_sec = 0;
         last;
      }

      if($in_sec) {
         $content .= $line . $/;
      }
   }
   close($fh);

   return $content;
}

1;
