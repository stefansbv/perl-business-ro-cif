#!/usr/bin/env perl

use strict;
use warnings;

my $cif = shift;

cif_ok($cif);

sub cif_ok {
    my $cif = shift;

    return unless ($cif);

    # Trim spaces to be safe
    $cif =~ s/^\s+//;
    $cif =~ s/\s+$//;

    if ( length($cif) >= 10 ) {
        print "CIF eronat (lungime > 10)\n";
        return;
    }

    my @cif = reverse split( //, $cif );
    my @prd = reverse split( //, '753217532' );

    my $ct = shift @cif;
    print "Cheia     = $ct\n";

    my $suma = 0;
    foreach ( 0 .. $#cif ) {
        $suma += $cif[$_] * $prd[$_];
    }

    print "Suma     = $suma\n";
    $suma *= 10;

    my $m11 = $suma % 11;

    print "Modulo11 = $m11\n";

    my $ctc;
    if ( $m11 == 10 ) {
        $ctc = 0;
    }
    else {
        $ctc = $m11;
    }

    # Final chech
    if ( $ct == $ctc ) {
        print "CIF valid\n";
    }
    else {
        print "CIF eronat\n";
    }

    return;
}
