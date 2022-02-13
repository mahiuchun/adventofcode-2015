#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

sub strtoarr {
    my $s = shift;
    my @a = (0) x (length $s);
    for (my $i = 0; $i < (scalar @a); $i++) {
	if (substr($s, $i, 1) eq '#') {
	    $a[$i] = 1;
	}
    }
    return @a;
}

my @grid = ();
my @next = ();
my $row = 0;
my $col = 0;

while (<$fh>) {
    chomp;
    $col = length $_;
    push @grid, [strtoarr $_];
    push @next, [(0) x $col];
}
$row = (scalar @grid);
$grid[0][0] = 1;
$grid[$row-1][0] = 1;
$grid[0][$col-1] = 1;
$grid[$row-1][$col-1] = 1;

sub lookup {
    my $r = shift;
    my $c = shift;
    if ($r < 0 or $r >= $row) {
	return 0;
    }
    if ($c < 0 or $c >= $col) {
	return 0;
    }
    return $grid[$r][$c];
}

sub num_nbs {
    my $r = shift;
    my $c = shift;
    my $result = 0;
    for (my $i = -1; $i <= 1; $i++) {
	for (my $j = -1; $j <= 1; $j++) {
	    if ($i == 0 and $j == 0) {
		next;
	    }
	    $result += lookup($r + $i, $c + $j);
	}
    }
    return $result;
}

for (my $t = 1; $t <= 100; $t++) {
    for (my $r = 0; $r < $row; $r++) {
	for (my $c = 0; $c < $col; $c++) {
	    my $x = num_nbs($r, $c) + 0.5 * $grid[$r][$c];
	    if (2.1 < $x and $x < 3.9) {
		$next[$r][$c] = 1;
	    } else {
		$next[$r][$c] = 0;
	    }
	}
    }
    $next[0][0] = 1;
    $next[$row-1][0] = 1;
    $next[0][$col-1] = 1;
    $next[$row-1][$col-1] = 1;
    my $num_on = 0;
    for (my $r = 0; $r < $row; $r++) {
	for (my $c = 0; $c < $col; $c++) {
	    $grid[$r][$c] = $next[$r][$c];
	    $num_on += $next[$r][$c];
	}
    }
    if ($t == 5 or $t == 100) {
	say 'After ', $t, ' steps ', $num_on, ' on';
    }
}
