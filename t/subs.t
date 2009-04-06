use Test::More qw(no_plan);

package Foo;
sub hello {"hello"}
sub world {"world"}

package Bar;
use Class::Implant;
implant qw(Foo);

package main;
can_ok(Bar,qw(hello world))
