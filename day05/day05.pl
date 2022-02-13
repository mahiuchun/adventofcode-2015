#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";
my $n = 0;
while (<$fh>) {
    chop $_;
    my $p2 = ($_ =~ /(.)\1/);
    my $p3 = !($_ =~ /ab|cd|pq|xy/);
    $_ =~ s/[^aeiou]//g;
    my $p1 = (length($_) >= 3);
    if ($p1 && $p2 && $p3) {
	$n++;
    }
}
say "Answer is ", $n
