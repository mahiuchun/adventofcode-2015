#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Math::Prime::Util qw(forperm);

open my $fh, '<', "input"
    or die "Can't open file: $!";

my %pairs = ();
my %nodes = ();
my $best = 0;

while (<$fh>) {
    chomp;
    my @parts = split / = /;
    my @cities = split / to /, $parts[0];
    my $key1 = join ' to ', @cities;
    my $key2 = join ' to ', (reverse @cities);
    $pairs{$key1} = int($parts[1]);
    $pairs{$key2} = int($parts[1]);
    $nodes{$cities[0]} = 1;
    $nodes{$cities[1]} = 1;
}
my @a = sort (keys %nodes);

forperm {
    my @b = @a[@_];
    my $sum = 0;
    for (my $i = 0; $i < (scalar @a) - 1; $i++) {
	my @cities = ($b[$i], $b[$i+1]);
	my $key = join ' to ', @cities;
	$sum += $pairs{$key};
    }
    if ($sum > $best) {
	$best = $sum;
    }
} @a;
say $best;
