package Exto;
# ABSTRACT: Exto::dus Loader

use strict;
use warnings;
use Import::Into;
use Module::Runtime qw( use_module );
use Data::OptList;

sub import {
  my ( $class, @modules ) = @_;
  my $target = caller;
  for (qw( strict warnings Carp )) {
    use_module($_)->import::into($target);
  }
  my @optlist = @{Data::OptList::mkopt([@modules],{
    must_be => [qw( ARRAY HASH )],
  })};
  for (@optlist) {
    my $package = 'Exto::'.$_->[0];
    my $opts = $_->[1];
    my @args = ref $opts eq 'ARRAY'
      ? @{$opts}
      : ref $opts eq 'HASH'
        ? %{$opts}
        : ();
    use_module($package)->import::into($target,@args);
  }
}

1;
