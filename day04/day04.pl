#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use Digest::MD5  qw(md5 md5_hex md5_base64);

open my $fh, '<', "input"
    or die "Can't open file: $!";
my $n = 0;
while (<$fh>) {
    chop $_;
    while (1) {
	my $hash = md5_hex($_ . $n);
	if (rindex($hash, "00000", 0) == 0) {
	    last;
	}
	$n++;
    }
}
say "Answer is ", $n
