#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my @a = ();
while (<$fh>) {
    chomp;
    my @props = /^\S+: capacity (\S+), durability (\S+), flavor (\S+), texture (\S+), calories (\S+)$/;
    push @a, [@props];
}
my @b = (0) x (scalar @a);

sub backtrack {
    my ($remain, $d) = @_;
    my $best = 0;
    if ($d == (scalar @a)) {
	$b[$d-1] = $remain;
	my $prod = 1;
	for (my $i = 0; $i < 4; $i++) {
	    my $term = 0;
	    for (my $j = 0; $j < (scalar @b); $j++) {
		$term += $b[$j] * $a[$j][$i];
	    }
	    $term = max(0, $term);
	    $prod *= $term;
	}
	return $prod;
    }
    for (my $i = 0; $i <= $remain; $i++) {
	$b[$d-1] = $i;
	$best = max($best, backtrack($remain - $i, $d + 1));
    }
    return $best;
}

say backtrack(100, 1);
