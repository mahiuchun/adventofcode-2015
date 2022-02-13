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

sub by_len_diff {
    (length($$b[1]) - length($$b[0])) <=> (length($$a[1]) - length($$a[0]))
}

@replacements = sort by_len_diff @replacements;

my $m = '';
while (<$fh>) {
    chomp;
    $m = $_;
}

# Greedy ???
my $steps = 0;
while ($m ne 'e') {
    for my $r (@replacements) {
	my $where = index($m, $$r[1]);
	if ($where != -1) {
	    $m = substr($m, 0, $where) . $$r[0] . substr($m, $where+(length $$r[1]));
	    last;
	}
    }
    $steps++;
}
say $steps;
