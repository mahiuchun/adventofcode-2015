#!/usr/bin/env perl
use strict;
use warnings;

open my $in, '<', "input" or die "failed to open input file";
my $floor = 0;

while( <$in> ) {
    my @a = split( /\s*/, $_ );
    foreach( @a ) {
	if( $_ eq "(" ) {
	    $floor += 1;
	} else {
	    $floor -= 1;
	}
    }
}

print $floor, "\n";
