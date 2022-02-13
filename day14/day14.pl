#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $best = 0;
my $tot = 2503;
while (<$fh>) {
    chomp;
    my ($name, $speed, $duration, $rest) = /^(\S+) can fly (\S+) km\/s for (\S+) seconds, but then must rest for (\S+) seconds.$/;
    my $t = 0;
    my $d = 0;
    while ($t + $duration + $rest <= $tot) {
	$d += $speed * $duration;
	$t += $duration;
	$t += $rest;
    }
    $d += min($duration, $tot - $t) * $speed;
    $best = max $d, $best;
}
say $best

