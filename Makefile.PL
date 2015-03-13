use 5.010;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Business-RO-CIF';
all_from 'lib/Business/RO/CIF.pm';
author   q{Stefan Suciu <stefan@s2i2.ro>};
license  'perl';

perl_version 5.010;

tests_recursive('t');

resources (
   #homepage   => 'http://yourwebsitehere.com',
   #IRC        => 'irc://irc.perl.org/#Business-RO-CIF',
   license    => 'http://dev.perl.org/licenses/',
   repository => 'git://github.com/stefansbv/perl-business-ro-cif.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-RO-CIF',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   #'ABC'              => 1.6,
   #'Foo::Bar::Module' => 5.0401,
);

install_as_cpan;
auto_install;
WriteAll;
