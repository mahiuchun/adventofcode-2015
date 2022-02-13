#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my @ws = ();
while (<$fh>) {
    chomp;
    push @ws, int($_);
}
my $sum = 0;
for my $w (@ws) {
    $sum += $w;
}

my $goal = $sum / 4;
sub backtrack {
    my ($i, $s_sofar, $p_sofar, $d, $maxd) = @_;
    if ($d == $maxd) {
	if ($s_sofar == $goal) {
	    return $p_sofar;
	} else {
	    return -1;
	}
    }
    if ($i >= (scalar @ws)) {
	return -1;
    }
    my $best = -1;
    for (my $j = $i; $j < (scalar @ws); $j++) {
	my $w = $ws[$j];
	my $curr = backtrack($j + 1, $s_sofar + $w, $p_sofar * $w, $d + 1, $maxd);
	if ($best < 0) {
	    $best = $curr;
	} elsif ($curr > 0) {
	    $best = min($best, $curr);
	}
    }
    return $best;
}

for (my $d = 1; $d < (scalar @ws)/4; $d++) {
    my $best = backtrack 0, 0, 1, 0, $d;
    if ($best > 0) {
	say $best;
	last;
    }
}
