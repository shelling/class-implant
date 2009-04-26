#!/usr/bin/env perl -w
use strict;
use Test::More tests => 1;
use FindBin;
use lib "$FindBin::Bin/lib";

package Fnord;
use Class::Implant;

implant 'Empty';

package main;
pass "implanting from an Empty class shouldn't break";

