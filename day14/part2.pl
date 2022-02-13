#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $tot = 2503;
my @pos = ();
my @score = ();
while (<$fh>) {
    chomp;
    my ($name, $speed, $duration, $rest) = /^(\S+) can fly (\S+) km\/s for (\S+) seconds, but then must rest for (\S+) seconds.$/;
    my $t = 0;
    my $d = 0;
    my @a = (0);
    my $i = 0;
    while ($t + $duration + $rest <= $tot) {
	for ($i = $t + 1; $i <= $t + $duration; $i++) {
	    $d += $speed;
	    push @a, $d;
	}
	$t += $duration;
	for ($i = $t + 1; $i <= $t + $rest; $i++) {
	    push @a, $d;
	}
	$t += $rest;
    }
    for ($i = $t + 1; $i <= min($t + $duration, $tot); $i++) {
	$d += $speed;
	push @a, $d;
    }
    for ( ; $i <= $tot; $i++) {
	push @a, $d;
    }
    push @pos, [@a];
    push @score, [(0) x ($tot + 1)];
}
for my $i (1 .. $tot) {
    my $lead = 0;
    for my $j (0 .. (scalar @pos)-1) {
	$lead = max($lead, $pos[$j][$i]);
    }
    for my $j (0 .. (scalar @pos)-1) {
	if ($lead == $pos[$j][$i]) {
	    $score[$j][$i] = $score[$j][$i-1] + 1;
	} else {
	    $score[$j][$i] = $score[$j][$i-1];
	}
	if ($i == 1000) {
	    say '1000th ',$score[$j][$i];
	}
    }
    if ($i == $tot) {
	my $best = 0;
	for my $j (0 .. (scalar @pos)-1) {
	    $best = max($best, $score[$j][$i]);
	}
	say $best; 
    }
}
