use Test::More 'no_plan';

use File::Basename;
use lib dirname(__FILE__) . "/lib";
use Foo;
use Bar;
use Spam;

use Class::Implant;
use Class::Inspector;

implant qw(Foo Spam), { into => 'Bar', match => qr{h\w+} };

can_ok("Bar", qw(hello hill));

ok(!defined(Bar->can("world")));
ok(!defined(Bar->can("spam")));
