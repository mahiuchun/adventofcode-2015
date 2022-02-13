#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $tot_c = 0;
my $tot_e = 0;

while (<$fh>) {
    chomp;
    $tot_c += length;
    $tot_e += length;
    $tot_e += 2;
    for my $ch (split //) {
	if ($ch eq '"') {
	    $tot_e++;
	} elsif ($ch eq '\\') {
	    $tot_e++;
	}
    }
}

say $tot_e,'-',$tot_c,'=',$tot_e-$tot_c;

