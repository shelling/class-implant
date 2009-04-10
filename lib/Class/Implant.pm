package Class::Implant;
# ABSTRACT: Manipulating mixin and inheritance out of packages

use 5.008008;
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

  my $target = caller;

  if (defined($option)) {
  # options preprocessing

      $target = $option->{into} if defined($option->{into});
      eval qq{ package $target; use base qw(@class); } if $option->{inherit};

      if (defined($option->{spec})) {
        for (qw(match include exclude)) {
          $option->{$_} = undef;
        }
      }

  }


  for my $class (reverse @class) {

    my @methods = @{ get_methods($class) };
    @methods = grep /$option->{match}/, @methods if $option->{match};

    for my $function (@methods) {
      *{ $target . "::" . $function } = \&{ $class . "::" . $function };
    }

  }

}

sub get_methods { Class::Inspector->functions(shift) }


1;

=head1 SYNOPSIS

There are two ways to use Class::Implant.

procedural way as follow.

  package main;
  use Class::Implant;

  implant qw(Foo::Bar Less::More) { into => "Cat" }   # import all methods in Foo::Bar and Less::More into Cat

or in classical way. just using caller as default target for implanting.

  package Cat;
  use Class::Implant;

  implant qw(Less::More);                 # mixing all methods from Less::More, 
                                          # like ruby 'include'

  implant qw(Foo::Bar), { inherit => 1 }; # import all methods from Foo::Bar and inherit it
                                          # it just do one more step: unshift Foo::Bar into @ISA
                                          # this step is trivial in Perl
                                          # but present a verisimilitude simulation of inheritance in Ruby


=head1 DESCRIPTION

Class::Implant allow you manipulating mixin and inheritance outside of packages.

syntax is like

  use Class::Implant;

  implant @classes_for_injection, { options => value }

available options show as following.

=head2 into

target package for injection.

=head2 inherit

give 1 or any value to mark the inheritance

=head2 spec

specify what methods you want to import

=head2 match

give a pattern to import methods which match this pattern

=head2 include

this option is not available in 0.01

=head2 exclude

this option is not available in 0.01


=head1 EXPORT

implant()

