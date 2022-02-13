#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

sub looks_like_number {
    my $s = shift;
    return $s =~ /^[0-9]+$/;
}

my %signal = ();

open my $fh, '<', "input"
    or die "Can't open file: $!";

while (<$fh>) {
    chomp $_;
    my @conn = split / -> /;
    $signal{$conn[1]} = looks_like_number($conn[0]) ? int($conn[0]) : $conn[0];
}

my $cont = 1;
while ($cont) {
    $cont = 0;
    for my $key (keys %signal) {
	my $val = $signal{$key};
	if (looks_like_number $val) {
	    next;
	}
	my @expr = split / /, $val;
	my $v1 = shift @expr;
	my $op = shift @expr;
	if (not $op) {
	    $signal{$key} = $signal{$v1};
	    $cont = 1;
	    next;
	}
	my $v2 = 0;
	if ($v1 eq "NOT") {
	    ($op, $v1) = ($v1, $op);
	} else {
	    $v2 = shift @expr;
	}
	if (not looks_like_number($v1)) {
	    $v1 = $signal{$v1};
	}
	if (not looks_like_number($v2)) {
	    $v2 = $signal{$v2};
	}
	if (!looks_like_number($v1) || !looks_like_number($v2)) {
	    next;
	}
	if ($op eq "NOT") {
	    $signal{$key} = 65535 - $v1;
	    $cont = 1;
	} elsif ($op eq "AND") {
	    $signal{$key} = int($v1) & int($v2);
	    $cont = 1;
	} elsif ($op eq "OR") {
	    $signal{$key} = int($v1) | int($v2);
	    $cont = 1;
	} elsif ($op eq "LSHIFT") {
	    $signal{$key} = $v1 << $v2;
	    $cont = 1;
	} elsif ($op eq "RSHIFT") {
	    $signal{$key} = $v1 >> $v2;
	    $cont = 1;
	} else {
	    die "Unknown op: $op";
	}
	$signal{$key} %= 65536;
    }
}
for (sort (keys %signal)) {
    say $_, ': ', $signal{$_};
}
say "Answer is ", $signal{'a'}
