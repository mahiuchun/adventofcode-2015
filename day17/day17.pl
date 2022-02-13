#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my @caps = ();
while (<$fh>) {
    chomp;
    push @caps, int($_);
}
my $fit = 150;
my @dp1 = (0) x ($fit + 1);
my @dp2 = (0) x ($fit + 1);

$dp1[0] = $dp2[0] = 1;
for my $cap (@caps) {
    for (my $i = 0; $i <= $fit - $cap; $i++) {
	$dp2[$i + $cap] += $dp1[$i];
    }
    for (my $i = 0; $i <= $fit; $i++) {
	$dp1[$i] = $dp2[$i];
    }
}
say $dp2[$fit];
