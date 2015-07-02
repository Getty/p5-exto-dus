package Exto::Role::JavaScript;

use Exto qw(
  Role
  Util::Js
);

with qw(
  Exto::Role::Uuid
);

requires qw(
  javascript
);

use overload '""' => sub {
  my $self = shift;
  return $self->javascript;
}, fallback => 1;

sub TO_JSON {
  my ( $self ) = @_;
  return js_raw_insert($self->uuid,$self->javascript);
}

1;