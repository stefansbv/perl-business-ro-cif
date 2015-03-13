
use strict;
use warnings;
use Test::More;
use Business::RO::CIF;

my $text = '12345';
ok my $cif = Business::RO::CIF->new( cif => $text ), 'new instance';
is $cif->valid, 0, 'not valid';
like $cif->why, qr/short/, 'too short';

$text = '12345678901';
ok $cif = Business::RO::CIF->new( cif => $text ), 'new instance';
is $cif->valid, 0, 'not valid';
like $cif->why, qr/long/, 'too long';

done_testing;
