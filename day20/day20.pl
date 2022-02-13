#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );
use Math::Prime::Util qw( divisor_sum );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $n = 0;
while (<$fh>) {
    chomp;
    $n = int($_);
}
$n /= 10;

for (my $i = 1; ; $i+=1) {
    if (divisor_sum($i) >= $n) {
	say $i;
	last;
    }
}
