use Test::More qw(no_plan);

use File::Basename;
use lib dirname(__FILE__) . "/lib";
use Foo;
use Bar;
use Spam;

package Bar;
use Class::Implant;
implant qw(Foo Spam), { inherit => 1 };

package main;

use_ok("Bar", qw(hello world spam));

$bar = Bar->new;
isa_ok($bar, "Foo", "Is Bar a Foo?");
isa_ok($bar, "Spam", "Is Bar a Spam?");
