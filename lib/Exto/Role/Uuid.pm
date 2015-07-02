package Exto::Role::Uuid;

use Exto qw(
  Util::Role
);

use Data::UUID;

has uuid => (
  is => 'lazy',
);

sub _build_uuid { Data::UUID->new->create_str() }

1;