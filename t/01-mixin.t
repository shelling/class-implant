use Test::More qw(no_plan);

use File::Basename;
use lib dirname(__FILE__) . "/lib";
use Foo;
use Bar;
use Spam;

package Bar;
use Class::Implant;
implant qw(Foo Spam);

package main;
can_ok(Bar, qw(hello world spam));
is(Bar::hello(), "hello");
is(Bar::world(), "world");
is(Bar::spam(),  "spam");
