package Exto::Util::Class;
# ABSTRACT: Exto Util for injecting Moo and base class infrastructure

use strict;
use warnings;
use MooX ();

our @base_import = (
  'late',
  '+Path::Tiny',
  '+Text::Trim',
  '+namespace::autoclean',
);

sub import {
  my ( $class, @custom_args ) = @_;
  my $target = caller;
  MooX->import::into($target, @base_import, @custom_args);
}

1;
