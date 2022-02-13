#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

open my $fh, '<', "input"
    or die "Can't open file: $!";

my @prog = ();
while (<$fh>) {
    chomp;
    push @prog, $_;
}

my $pc = 0;
my %reg = (a => 0, b => 0);

sub parse_off {
    my $s = shift;
    my $res = int(substr($s, 1));    
    if (substr($s, 0, 1) eq '-') {
	$res *= -1;
    }
    return $res;
}

while ($pc < (scalar @prog)) {
    my @parts = split /[ ,]+/, $prog[$pc];
    my $op = $parts[0];
    my $r = $parts[1];
    my $off = 0;
    if ($op eq 'hlf') {
	$reg{$r} /= 2;
    } elsif ($op eq 'tpl') {
	$reg{$r} *= 3;
    } elsif ($op eq 'inc') {
	$reg{$r} += 1;
    } elsif ($op eq 'jmp') {
	$off = parse_off $parts[1];
	$pc += $off;
	next;
    } elsif ($op eq 'jie') {
	$off = parse_off $parts[2];
	if ($reg{$r} % 2 == 0) {
	    $pc += $off;
	    next;
	}
    } elsif ($op eq 'jio') {
	$off =parse_off $parts[2];
	if ($reg{$r} == 1) {
            $pc += $off;
            next;
        }
    } else {
	die "Invalid op: $op.";
    }
    $pc++;
}
say $reg{b};
