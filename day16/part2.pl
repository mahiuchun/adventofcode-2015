#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my %h = (
    children => 3,
    cats => 7,
    samoyeds => 2,
    pomeranians => 3,
    akitas => 0,
    vizslas => 0,
    goldfish => 5,
    trees => 3,
    cars => 2,
    perfumes => 1,
);
my %gt = (
    cats => 1,
    trees => 1,
);
my %lt = (
    pomeranians => 1,
    goldfish => 1,
);

while (<$fh>) {
    chomp;
    my ($n, @kv) = /^Sue (\S+): (\S+): (\S+), (\S+): (\S+), (\S+): (\S+)$/;
    my %hh = (@kv);
    my $differ = 0;
    while (my ($k, $v) = each %hh) {
	if ($gt{$k}) {
	    if ($hh{$k} <= $h{$k}) {
		$differ = 1;
		last;
	    }
	} elsif ($lt{$k}) {
	    if ($hh{$k} >= $h{$k}) {
		$differ = 1;
		last;
	    }
	} else {
	    if ($hh{$k} != $h{$k}) {
		$differ = 1;
		last;
	    }
	}
    }
    if (not $differ) {
	say $n;
	last;
    }
}
