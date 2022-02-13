#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Math::Prime::Util qw(forperm);

open my $fh, '<', "input"
    or die "Can't open file: $!";

my %pairs = ();
my %nodes = ();
my @orig = ();

while (<$fh>) {
    chomp;
    my ($p1, $dir, $val, $p2) = /^(\S+) would (\S+) (\S+) happiness units by sitting next to (\S+).$/;
    my $key = $p1 . '-' . $p2;
    $pairs{$key} = int($val);
    if ($dir eq "lose") {
	$pairs{$key} *= -1;
    }
    $nodes{$p1} = 1;
    $nodes{$p2} = 1;
    if ((scalar @orig) == 0) {
	push @orig, $p1;
    } elsif ($orig[-1] ne $p1) {
	push @orig, $p1;
    }
}
# say @orig;

sub happiness {
    my ($a) = @_;
    my $sum = 0;
    for (my $i = 1; $i < (scalar @$a) ; $i++) {
	my @pair = ($$a[$i-1], $$a[$i]);
	my $key1 = join '-', @pair;
	my $key2 = join '-', (reverse @pair);
	$sum += $pairs{$key1};
	$sum += $pairs{$key2};
    }
    return $sum;
}

my $best = 0;
forperm {
    my @a = @orig[@_];
    my $t = happiness(\@a);
    if ($t > $best) {
	$best = $t;
    }
} @orig;
say $best;
