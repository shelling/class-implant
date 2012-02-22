# Class-Implant

Manipulating mixin and inheritance outside of packages

## INSTALLATION

To install this module type the following:

    perl Makefile.PL  
    make  
    make test  
    make install

## USAGE

There are two ways to use Class::Implant.

Classical way as follows.

    packagg Cat;
    use Class::Implant;

    implant qw(Foo Bar Baz), { inherit => 1, match => qr{pattern} };
    # import all methods from Foo, Bar, Baz into Cat

Procudural way

    packagg main;
    use Class::Implant;

    implant qw(Foo Baz), { 
        into    => "Cat",
        match   => qr{pattern} 
        include => [qw(foo bar)],
        exclude => [qw(baz kao)],
    };

    implant "Baz", {
        into    => "Cat",
        spec    => [qw(che tou)],
    }

Remark: while "spec" appear in options, "match", "include", and "exclude" would not work.


## DEPENDENCIES

This module requires these other modules and libraries:

    Exporter
    Class::Inspector

## SEE ALSO

    UNIVERSAL::implant
    Moose::Manual::Roles

## COPYRIGHT AND LICENCE

Copyright (C) 2009 by shelling

MIT(X11) Licence

