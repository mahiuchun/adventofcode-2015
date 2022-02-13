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
    my $res = 0;
    if (ref($r) eq 'ARRAY') {
	for my $e (@$r) {
	    $res += accum($e);
	}
    } elsif (ref($r) eq 'HASH') {
	my $sofar = 0;
	for my $e (values %$r) {
	    if ($e eq "red") {
		$sofar = 0;
		last;
	    }
	    $sofar += accum($e);
	}
	$res += $sofar;
    } else {
	if (looks_like_number($r)) {
	    return int($r);
	}
    }
    return $res;
}


while (<$fh>) {
    chomp;
    my $obj = decode_json $_;
    $sum += accum $obj;
}
say 'Answer is ', $sum;
