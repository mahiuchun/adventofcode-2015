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

while (<$fh>) {
    chomp;
    my ($n, @kv) = /^Sue (\S+): (\S+): (\S+), (\S+): (\S+), (\S+): (\S+)$/;
    my %hh = (@kv);
    my $differ = 0;
    while (my ($k, $v) = each %hh) {
	if ($h{$k} ne $v) {
	    $differ = 1;
	    last;
	}
    }
    if (not $differ) {
	say $n;
	last;
    }
}
