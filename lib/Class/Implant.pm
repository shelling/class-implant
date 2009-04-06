package Class::Implant;
# ABSTRACT: Manipulating mixin and inheritance out of packages

use 5.008008;
use strict;
no  strict "refs";
use warnings;
use Class::Inspector;

our $VERSION = '0.01_01';

sub import {
  *{(caller)[0] . "::implant"} = \&implant;
}

sub implant (@) {
  my $option = ( ref($_[-1]) eq "HASH" ? pop(@_) : undef );
  my @class = @_;

  my $caller = caller;
  my $target = $caller;

 #if ( defined($option->{inherit}) ) {
 #    eval qq{ package $caller; use base qw(@class); } 
 #}

  if (defined($option)) {
      $target = ($option->{into} ? $option->{into} : $caller );
      eval qq{ package $target; use base qw(@class); } if $option->{inherit};
  }

  for my $class (reverse @class) {
    for my $function (@{ Class::Inspector->functions($class) }) {
      *{ $target . "::" . $function } = \&{ $class . "::" . $function };
    }
  }

}

1;
__END__

=head1 NAME

Class::Implant - Manipulating Mix-In and Inheritance of Packages from outside

=head1 SYNOPSIS

  package Cat;
  use Class::Implant;
  implant qw(Foo::Bar), { inherit => 1 }; # import all methods from Foo::Bar and inherit it
                                          # just like inheritance of ruby

  implant qw(Less::More);                 # mixing all methods from Less::More, 
                                          # like ruby 'include'


=head1 DESCRIPTION

Simply do mix-in [inheritance] in intuitive way

=head2 EXPORT

&implant()


=head1 SEE ALSO



Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

shelling, E<lt>shelling@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by shelling

MIT(X11) Licence

=cut
