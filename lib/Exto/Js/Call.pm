package Exto::Js::Call;

use Exto qw(
  Util::Class
  Util::Js
);

has args => (
  is => 'lazy',
);

sub _build_args {[]}

has func => (
  is => 'ro',
  required => 1,
);

has javascript => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_javascript {
  my ( $self ) = @_;
  my $js = $self->func.'(';
  $js .= join(',',map { js_encode($_) } @{$self->args});
  $js .= ')';
  return $js;
}

with qw(
  Exto::Role::JavaScript
);

sub BUILDARGS {
  my ( $class, @args ) = @_;
  my $func = shift @args;
  return {
    func => $func,
    args => [@args],
  };
}

1;