#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use JSON;
use Scalar::Util qw(looks_like_number);

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $sum = 0;

sub accum {
    my ($r) = @_;
    if (ref($r) eq 'ARRAY') {
	for my $e (@$r) {
	    $sum += accum($e);
	}
    } elsif (ref($r) eq 'HASH') {
	for my $e (values %$r) {
	    $sum += accum($e);
	}
    } else {
	if (looks_like_number($r)) {
	    return int($r);
	} else {
	    return 0;
	}
    }
}


while (<$fh>) {
    chomp;
    my $obj = decode_json $_;
    accum $obj;
}
say 'Answer is ', $sum;
