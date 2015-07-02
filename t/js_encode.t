#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Exto qw(
  Util::Js
  Util
);

my $rand = "RAND".time(); # time is a bit random, right?

is(js_encode($rand),json_encode($rand),'Simple string');
is(js_encode(js($rand)),$rand,'Simple JS string');

is(js_encode(jf(qw( a b c ),qq{ return })),qq{function(a,b,c){
var self = this;
return}},'Simple JS function');

is(js_encode(jc('SomeWhere.Function',$rand)),qq{SomeWhere.Function("$rand")},'Simple JS call');

is(js_encode([
  jf(qw( a b ),qq{
    return
  }), jc('SomeWhere.Factory',$rand),
  $rand,
]),qq{[function(a,b){
var self = this;
return},SomeWhere.Factory("$rand"),"$rand"]},'Simple mixed array');

# print "\n====\n";

# my $testfunc = jf(qw( test me ),qq{ return });

# print $js->encode({
#   test => $testfunc,
#   deep => [ $testfunc ]
# });

# print "\n====\n";

# my $class = Exto::Js::ExtClass->define('Foo.bar.Derived',
#   extend => 'Foo.bar.Base',
#   destroy => jf(qq{
#     console.log('DESTROY!');
#   })
# );

# print $class->javascript;

# print "\n====\n";

# print $class->create_javascript();

# print "\n====\n";


done_testing;

