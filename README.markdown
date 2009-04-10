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

    implant qw(Foo Bar Baz), { option hash ref };
    \# import all methods from Foo, Bar, Baz into Cat

Procudural way

    packagg main;
    use Class::Implant;

    implant qw(Foo Baz Baz), { into => "Cat", match => qr{pattern} };



## DEPENDENCIES

This module requires these other modules and libraries:

    Exporter
    Class::Inspector

## COPYRIGHT AND LICENCE

Copyright (C) 2009 by shelling

MIT(X11) Licence

