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
my @dp = ();
for (my $i = 0; $i <= (scalar @caps); $i++) {
    push @dp, [(0) x ($fit + 1)];
}

$dp[0][0] = 1;
for (my $i = 0; $i < (scalar @caps); $i++) {
    my $cap = $caps[$i];
    for (my $j = $i + 1; $j >= 1; $j--) {
	for (my $k = 0; $k <= $fit - $cap; $k++) {
	    $dp[$j][$k+$cap] += $dp[$j-1][$k];
	}
    }
}
for (my $i = 0; $i <= (scalar @caps); $i++) {
    if ($dp[$i][$fit] > 0) {
	say $dp[$i][$fit];
	last;
    }
}
