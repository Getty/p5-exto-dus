package Exto::Util::Js;
# ABSTRACT: Functions to convert Exto::Js to JavaScript

use Exto;
use JSON::MaybeXS;
use Exporter 'import';
use Data::UUID;

our @EXPORT = qw(
  js_encode
  json_encode
  js_raw_insert
);

our $j = JSON::MaybeXS->new
  ->utf8(1)
  ->allow_nonref(1)
  ->allow_blessed(1)
  ->convert_blessed(1);

my $current_encode;
my %raws;

sub js_raw_insert {
  my ( $uuid, $js ) = @_;
  croak "Currently not encoding JS (You can't json encode Exto Js objects)" unless $current_encode;
  $raws{$current_encode} = {} unless defined $raws{$current_encode};
  my $identifier = $current_encode.'_Exto_Util_Js_Conversion_'.$uuid;
  $raws{$current_encode}->{$identifier} = $js;
  return $identifier;
}

sub json_encode {
  my ( $data ) = @_;
  return $j->encode($data);
}

sub js_encode {
  my ( $element ) = @_;
  my $old_encode = $current_encode;
  my $my_encode = Data::UUID->new->create_str;
  $current_encode = $my_encode;
  my $json = json_encode($element);
  for my $from (keys %{$raws{$my_encode}}) {
    my $to = delete $raws{$my_encode}->{$from};
    my $count = scalar ( $json =~ s/"$from"/$to/g );
    croak "UUID of JavaScript not found in JSON" unless $count >= 1;
  }
  $current_encode = $old_encode;
  return $json;
}

1;