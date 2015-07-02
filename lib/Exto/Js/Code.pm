package Exto::Js::Code;

use Exto qw(
  Util::Class
);

has code => (
  is => 'ro',
  required => 1,
);

has javascript => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_javascript {
  my ( $self ) = @_;
  my $trimmed = trim($self->code);
  my $last = substr($trimmed,-1);
  $trimmed = substr($trimmed,0,-1) if $last eq ';';
  return $trimmed;
}

with qw(
  Exto::Role::JavaScript
);

sub BUILDARGS {
  my ( $class, @args ) = @_;
  return { code => join(";\n",map { trim($_) } @args) };
}

1;