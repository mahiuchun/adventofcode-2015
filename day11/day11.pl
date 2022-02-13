#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

sub inc_pass {
    my $p = shift;
    my @a = map ord($_)-ord('a'), (split //, $p);
    my $i;
    for ($i = 0; $i < (scalar @a); $i++) {
	if (substr($p, $i, 1) =~ /[iol]/) {
	    $a[$i] += 1;
	    for (my $j = $i + 1; $j < (scalar @a); $j++) {
		$a[$j] = 0;
	    }
	    last;
	}
    }
    if ($i == (scalar @a)) {
	my $carry = 1;
	for ($i = (scalar @a) - 1; $i >= 0; $i--) {
	    $a[$i] += $carry;
	    $carry = $a[$i] / 26;
	    $a[$i] %= 26;
	}
    }
    return join '', (map chr($_+ord('a')), @a)
}

sub pass_ok {
    my $p = shift;
    my $i;
    for ($i = 0; $i < (length $p) - 2; $i++) {
	my $c1 = substr $p, $i, 1;
	my $c2 = substr $p, $i+1, 1;
	my $c3 = substr $p, $i+2, 1;
	if (ord($c1)+1 == ord($c2) and ord($c2)+1 == ord($c3)) {
	    last;
	}
    }
    if ($i == (length $p) - 2) {
	return 0;
    }
    if ($p =~ /[iol]/) {
	return 0;
    }
    if (not ($p =~ /(.)\1.*(.)\2/)) {
	return 0;
    }
    return 1;
}

open my $fh, '<', "input"
    or die "Can't open file: $!";

my $s;
while (<$fh>) {
    chomp;
    $s = $_;
}
say 'Input was ', $s;
do {
    $s = inc_pass $s;
} while (not pass_ok $s);
say 'Answer is ', $s;
