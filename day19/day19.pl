#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my @replacements = ();
while (<$fh>) {
    chomp;
    if ($_ eq '') {
	last;
    }
    push @replacements, [split(/ => /, $_)];
}
my $molecule = '';
while (<$fh>) {
    chomp;
    $molecule = $_;
}
my %seen = ();
for my $r (@replacements) {
    my $where = -1;
    for (;;) {
	$where = index($molecule, $$r[0], $where+1);
	if ($where < 0) {
	    last;
	}
	my $new_m = substr($molecule, 0, $where) . $$r[1] . substr($molecule, $where + (length $$r[0]));
	$seen{$new_m} = 1;
    }
}
say scalar(%seen)
