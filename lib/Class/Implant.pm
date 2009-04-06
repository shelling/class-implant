package Class::Implant;
# ABSTRACT: Manipulating mixin and inheritance out of packages

use 5.008008;
use strict;
no  strict "refs";
use warnings;
use Class::Inspector;

our $VERSION = '0.01';

sub import {
  *{(caller)[0] . "::implant"} = \&implant;
}

sub implant (@) {
  my $option = ( ref($_[-1]) eq "HASH" ? pop(@_) : undef );
  my @class = @_;

  my $target = caller;

  if (defined($option)) {
      $target = $option->{into} if defined($option->{into});
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

=head1 SYNOPSIS

  package Cat;
  use Class::Implant;
  implant qw(Foo::Bar), { inherit => 1 }; # import all methods from Foo::Bar and inherit it
                                          # just like inheritance of ruby

  implant qw(Less::More);                 # mixing all methods from Less::More, 
                                          # like ruby 'include'


=head1 DESCRIPTION

Manipulating mixin and inheritance outside of packages

=head2 EXPORT

&implant()


=head1 SEE ALSO


=head1 AUTHOR

shelling, E<lt>shelling@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by shelling

MIT(X11) Licence

=cut
