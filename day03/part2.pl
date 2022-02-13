#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

open my $fh, '<', "input"
    or die "Can't open file: $!";
my %vis = ( "0,0"=>1 );

sub deliver {
    my $str = $_[0];
    my $x = 0;
    my $y = 0;
    # say $str;
    for (split //, $str) {
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

while (<$fh>) {
    chop $_;
    my @ss = ('', '');
    my $i = 0;
    for (split //, $_) {
	$ss[$i] = $ss[$i] . $_;
	$i = 1 - $i;
    }
    deliver($ss[0]);
    deliver($ss[1]);
}
say "Answer is ", scalar %vis
