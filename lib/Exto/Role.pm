package Exto::Role;
# ABSTRACT: Exto Base Role

use strict;
use warnings;
use Exto::Class ();
use MooX::Role ();

sub import {
  my ( $class, @custom_args ) = @_;
  my $target = caller;
  MooX::Role->import::into(
    $target, @Exto::Class::base_import, @custom_args
  );
}

1;
