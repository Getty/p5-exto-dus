
requires 'Data::OptList', '0.107';
requires 'Import::Into', '1.000003';
requires 'Module::Runtime', '0.013';
requires 'Moo', '2.0';
requires 'MooX', '0.101';
requires 'MooX::late', '0';
requires 'namespace::clean', '0';
requires 'Path::Tiny', '0';
requires 'Plack', '0';
requires 'Text::Trim', '0';
requires 'Text::Xslate', '0';

on test => sub {
  requires 'Test::More', '1.001014';
};
