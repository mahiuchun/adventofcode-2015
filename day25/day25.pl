#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $row;
my $col;
while (<$fh>) {
    chomp;
    ($row, $col) = /^To continue, please consult the code grid in the manual.  Enter the code at row (\S+), column (\S+).$/;
}
say $row, ',', $col;

sub toindex {
    my ($r, $c) = @_;
    my $rr = $r + $c - 1;
    my $start = $rr * ($rr - 1) / 2 + 1;
    return $start + $c - 1;
}
#for (my $i = 1; $i <= 6; $i++) {
#    for (my $j = 1; $j <= 6; $j++) {
#	say toindex($i, $j);
#    }
#}
my $idx = toindex($row, $col);
my $code = 20151125;
for (my $i = 1; $i < $idx; $i++) {
    $code = ($code * 252533) % 33554393;
}
say $code;
