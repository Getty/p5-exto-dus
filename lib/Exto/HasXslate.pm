package Exto::HasXslate;

use Exto qw(
  Role
);

use Text::Xslate qw( mark_raw );
use String::Truncate 'elide';

has xslate => (
  is => 'lazy',
  handles => [qw(
    render_string
  )],
);

sub _build_xslate {
  my ( $self ) = @_;
  Text::Xslate->new(
    functions => {
      r => sub { mark_raw(@_) },
      call => sub {
        my $thing = shift;
        my $func = shift;
        $thing->$func;
      },
      call_if => sub {
        my $thing = shift;
        my $func = shift;
        $thing->$func if $thing;
      },
      replace => sub {
        my $source = shift;
        my $from = shift;
        my $to = shift;
        $source =~ s/$from/$to/g;
        return $source;
      },
      truncate => &elide,
    },
  )
}

1;