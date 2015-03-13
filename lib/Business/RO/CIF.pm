package Business::RO::CIF;

use 5.010;
use strict;
use warnings;
use utf8;
use Moo;
use Types::Standard qw(Int ArrayRef Str);

our $VERSION = '0.01';

has 'cif' => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has 'why' => (
    is       => 'rw',
    isa      => Str,
);

has 'rev_key' => (
    is       => 'lazy',
    isa      => ArrayRef,
    init_arg => undef,
);

sub _build_rev_key {
    my $self = shift;
    my @revkey = reverse split //, '753217532';
    return \@revkey;
}

has 'checksum' => (
    is       => 'rw',
    isa      => Int,
    init_arg => undef,
);

has 'rev_cif' => (
    is       => 'lazy',
    isa      => ArrayRef,
    init_arg => undef,
);

sub _build_rev_cif {
    my $self = shift;
    if ( my $cif = $self->cif ) {
        my @revcif = reverse split //, $cif;
        $self->checksum(shift @revcif);
        return \@revcif;
    }
    else {
        die "No CIF?";
    }
}

sub valid {
    my $self = shift;

    my @rev_cif = @{ $self->rev_cif };
    my @rev_key = @{ $self->rev_key };

    my $len = scalar @rev_cif;
    if ($len < 5) {
        $self->why("too short");
        return 0;
    }
    if ($len > 9) {
        $self->why("too long");
        return 0;
    }

    my $sum = 0;
    foreach ( 0 .. $#rev_cif ) {
        $sum += $rev_cif[$_] * $rev_key[$_];
    }

    my $m11 = $sum * 10 % 11;
    my $ctc = $m11 == 10 ? 0 : $m11;

    return $self->checksum == $ctc ? 1 : 0;
}

# sub BUILDARGS {
#     my ( $class, @args ) = @_;
#     if ( @args == 1 && !ref $args[0] ) {
#         return { cif => $args[0] };
#     }
#     else {
#         return { @args };
#     }
# }

1;

__END__

=encoding utf8

=head1 NAME

Business::RO::CIF - The great new Business::RO::CIF!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Business::RO::CIF;

    my $foo = Business::RO::CIF->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 ATTRIBUTES

=head2 cif

=head2 rev_key

=head2 rev_cif

=head2 checksum

=head1 METHODS

=head2 BUILDARGS

=head1 AUTHOR

Stefan Suciu, C<< <stefan at s2i2.ro> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-business-ro-cif at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Business-RO-CIF>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Business::RO::CIF

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-RO-CIF>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Business-RO-CIF>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Business-RO-CIF>

=item * Search CPAN

L<http://search.cpan.org/dist/Business-RO-CIF/>

=back

=head1 ACKNOWLEDGEMENTS

Proiect creat în colaborare și din inițiativa lui Árpád Szász.

The module is inspired from the Business::RO::CNP module by Octavian Râșniță (TEDDY)

The validation algoritm is from L<http://ro.wikipedia.org/wiki/Cod_de_Identificare_Fiscal%C4%83>.

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Árpád Szász

Copyright 2015 Stefan Suciu.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut
