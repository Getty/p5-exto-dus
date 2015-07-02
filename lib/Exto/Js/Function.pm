package Exto::Js::Function;

use Exto qw(
  Util::Class
  Js::Code
);

has args => (
  is => 'lazy',
);

sub _build_args {[]}

has code => (
  isa => 'Exto::Js::Code',
  is => 'ro',
  required => 1,
);

has maps => (
  is => 'ro',
  predicate => 1,
);

has javascript => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_javascript {
  my ( $self ) = @_;
  my $js = 'function('.join(',',@{$self->args}).'){'."\n";
  $js .= 'var self = this;'."\n";
  if ($self->has_maps) {
    for my $from (keys %{$self->maps}) {
      my $to = $self->maps->{$from};
      $js .= 'var '.$from.' = self.'.$to.";\n";
    }
  }
  $js .= $self->code->javascript;
  $js .= '}';
  return $js;
}

with qw(
  Exto::Role::JavaScript
);  

sub BUILDARGS {
  my ( $class, @args ) = @_;
  my @args_and_code;
  my %maps;
  for my $arg (@args) {
    my $ref = ref $arg;
    if ($ref eq 'ARRAY') {
      for (@{$arg}) {
        $maps{$_} = $_;
      }
    } elsif ($ref eq 'HASH') {
      for (keys %{$arg}) {
        $maps{$_} = $arg->{$_};
      }
    } else {
      push @args_and_code, $arg;
    }
  }
  my $code = pop @args_and_code;
  if (!ref $code) {
    $code = Exto::Js::Code->new($code);
  }
  return {
    code => $code,
    @args_and_code ? ( args => [@args_and_code] ) : (),
    %maps ? ( maps => \%maps ) : (),
  };
}

1;