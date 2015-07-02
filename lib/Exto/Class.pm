package Exto::Class;
# ABSTRACT: Exto Base Class

use strict;
use warnings;
use MooX ();

our @base_import = (
  'late',
  '+Carp',
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
