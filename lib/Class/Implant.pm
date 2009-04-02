package Class::Implant;

use strict;
no  strict "refs";
use warnings;
use Class::Inspector;

sub import {
  *{(caller)[0] . "::implant"} = \&implant;
}

sub implant (@) {
  my $option = ( ref($_[-1]) eq "HASH" ? pop(@_) : undef );
  my @class = @_;

  my $caller = caller;

  if ( defined($option->{inherit}) ) {
      eval qq{ package $caller; use base qw(@class); } 
  }

  for my $class (reverse @class) {
    for my $function (@{ Class::Inspector->functions($class) }) {
      *{ $caller . "::" . $function } = \&{ $class . "::" . $function };
    }
  }

}

1;
