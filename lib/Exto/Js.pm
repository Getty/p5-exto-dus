package Exto::Js;
# ABSTRACT: Converts Data and JavaScript Objects to JavaScript

use Exporter 'import';

use Exto qw(
  Js::Call
  Js::Code
  Js::Function
);

our @EXPORT = qw( jc js jf );

sub jc { Exto::Js::Call->new(@_) }
sub js { Exto::Js::Code->new(@_) }
sub jf { Exto::Js::Function->new(@_) }

1;