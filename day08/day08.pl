#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $tot_c = 0;
my $tot_m = 0;

while (<$fh>) {
    chomp;
    $tot_c += length;
    $tot_m += length;
    $tot_m -= 2;
    chop;
    my $inside = substr $_, 1;
    # say $inside;
    my $i = 0;
    while ($i < length $inside) {
	my $ch = substr $inside, $i, 1;
	if ($ch ne "\\") {
	    $i++;
	    next;
	}
	my $ch2 = substr $inside, $i+1, 1;
	if ($ch2 eq "\\") {
	    $tot_m--;
	    $i++;
	} elsif ($ch2 eq "\"") {
	    $tot_m--;
	    $i++;
	} elsif ($ch2 eq "x") {
	    $tot_m -= 3;
	    $i++;
	} else {
	    die "Unknown ch2: $ch2";
	}
	$i++;
    }
}

say $tot_c,'-',$tot_m,'=',$tot_c-$tot_m;

