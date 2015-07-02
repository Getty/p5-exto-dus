package Exto::ExtJS6;

use Exto qw(
  Class
);

has path => (
  is => 'lazy',
);

sub _build_path {
  my $env_path = $ENV{EXTJS6_PATH}
    || croak __PACKAGE__." Requires EXTJS6_PATH variable";
  return $env_path;
}

has p => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_p {
  my ( $self ) = @_;
  my $path = path($self->path);
  croak __PACKAGE__." '".$path->stringify."' doesn't exist"
    unless $path->exists;
  croak __PACKAGE__." '".$path->stringify."' is not a directory"
    unless $path->is_dir;
  my $build = $path->child(qw( build ext-modern-all.js ));
  croak __PACKAGE__." can't find ExtJS Modern API, is that really ExtJS 6?"
    unless $build->exists && $build->is_file;
  return $path;
}

sub BUILD {
  my ( $self ) = @_;
  $self->p;
}

sub modern_api {
  my ( $self, $debug ) = @_;
  return $debug
    ? $self->p->child(qw( build ext-modern-all-debug.js ))
    : $self->p->child(qw( build ext-modern-all.js ))
}

1;