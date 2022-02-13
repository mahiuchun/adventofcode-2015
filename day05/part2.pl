#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";
my $n = 0;
while (<$fh>) {
    chop $_;
    my $p1 = ($_ =~ /(..).*\1/);
    my $p2 = ($_ =~ /(.).\1/);
    if ($p1 && $p2) {
	$n++;
    }
}
say "Answer is ", $n
