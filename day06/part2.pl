#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

sub coord {
    return map int, (split /,/, (shift @_));
}

open my $fh, '<', "input"
    or die "Can't open file: $!";
my @grid = ();
for my $i (0 .. 999) {
    my @row = ();
    for my $j (0 .. 999) {
	push @row, 0;
    }
    push @grid, [ @row ];
}

while (<$fh>) {
    my @inst = split;
    my $cmd = shift @inst;
    if ($cmd eq "turn") {
	$cmd = shift @inst;
    }
    my ($i1, $j1) = coord(shift @inst);
    shift @inst;
    my ($i2, $j2) = coord(shift @inst);
    for my $i ($i1 .. $i2) {
	for my $j ($j1 .. $j2) {
	    if ($cmd eq "on") {
		$grid[$i][$j] += 1;
	    } elsif ($cmd eq "off") {
		$grid[$i][$j] -= 1;
		if ($grid[$i][$j] < 0) {
		    $grid[$i][$j] = 0;
		}
	    } else {
		$grid[$i][$j] += 2;
	    }
	}
    }
}

my $n = 0;
for my $i (0 .. 999) {
    for my $j (0 ... 999) {
	$n += $grid[$i][$j];
    }
}
say "Answer is ", $n
