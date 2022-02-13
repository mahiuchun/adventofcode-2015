#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";
my %vis = ( "0,0"=>1 );
my $x = 0;
my $y = 0;
while (<$fh>) {
    chop $_;
    for (split //, $_) {
	if ($_ eq '<') {
	    $x--;
	} elsif ($_ eq '>') {
	    $x++;
	} elsif ($_ eq '^') {
	    $y++;
	} elsif ($_ eq 'v') {
	    $y--;
	} else {
	    say 'Something is wrong';
	}
	my @a = ($x, $y);
	my $key = join(',', @a);
	$vis{$key} = 1;
    }
}
say "Answer is ", scalar %vis
