package Exto::Util::Role;
# ABSTRACT: Exto Util for injecting Moo::Role and base class infrastructure

use strict;
use warnings;
use Exto::Util::Class ();
use MooX::Role ();

sub import {
  my ( $class, @custom_args ) = @_;
  my $target = caller;
  MooX::Role->import::into(
    $target, @Exto::Util::Class::base_import, @custom_args
  );
}

1;
