#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";
my $tot = 0;
while (<$fh>) {
    my ($l, $w, $h) = split /x/, $_;
    my @a = ($l, $w, $h);
    @a = sort { $a <=> $b } @a;
    $tot += 2 * ($a[0] + $a[1]) + $a[0] * $a[1] * $a[2];
}
say "Answer is ", $tot
