#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $s;

while (<$fh>) {
    chomp;
    $s = $_;
}
say 'Input was ', $s;
for (my $i = 1; $i <= 50; $i++) {
    my @a = ();
    my $prev = substr $s, 0, 1;
    my $count = 1;
    for (my $j = 1; $j < (length $s); $j++) {
	my $ch = substr $s, $j, 1;
	if ($ch eq $prev) {
	    $count++;
	} else {
	    push @a, $count;
	    push @a, $prev;
	    $count = 1;
	}
	$prev = $ch;
    }
    push @a, $count;
    push @a, $prev;
    $s = join '', @a;
    # say 'Applied ', $i, ' time(s) ', $s;
}
say 'Answer is ', (length $s);
