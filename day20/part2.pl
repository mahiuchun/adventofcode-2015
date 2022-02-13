#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );
use Math::Prime::Util qw( divisors );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $n = 0;
while (<$fh>) {
    chomp;
    $n = int($_);
}

sub presents {
    my $n = shift;
    my @divisors = divisors($n);
    my $res = 0;
    for my $d (@divisors) {
	if (50 * $d >= $n) {
	    $res += $d;
	}
    }
    return 11 * $res;
}

for (my $i = 1; ; $i+=1) {
    my $p = presents($i);
    if ($p >= $n) {
	say $i;
	last;
    }
}
