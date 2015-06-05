use strict;
use warnings;
use Test::More;
use Business::RO::CIF;

my $text = '12345o23';
ok my $cif = Business::RO::CIF->new( cif => $text ), 'new with invalid characters';
is $cif->valid, 0, 'valid';
like $cif->errstr, qr/invalid/, 'error string';

$text = '12345';
ok $cif = Business::RO::CIF->new( cif => $text ), 'new, too short';
is $cif->valid, 0, 'valid';
like $cif->errstr, qr/short/, 'error string';

$text = '12345678901';
ok $cif = Business::RO::CIF->new( cif => $text ), 'new, too long';
is $cif->valid, 0, 'valid';
like $cif->errstr, qr/long/, 'error string';

$text = '1234567890';
ok $cif = Business::RO::CIF->new( cif => $text ), 'new non valid CIF';
is $cif->valid, 0, 'valid';
like $cif->errstr, qr/checksum/, 'error string';

done_testing;
