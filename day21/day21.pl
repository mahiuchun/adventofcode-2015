#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );

use constant HP => 'Hit Points';

my %player = (HP() => 100, 'Damage' => 0, 'Armor' => 0);
my %boss = ();

open my $fh, '<', "input"
    or die "Can't open file: $!";
while (<$fh>) {
    chomp;
    my @parts = split /: /;
    $boss{$parts[0]} = int($parts[1]);
}

my @weapons = ();
my @armor = ();
my @rings = ();

my $inp_state = 0;
open my $fh2, '<', 'shop' or die "Can't open file: $!";
while (<$fh2>) {
    chomp;
    if (length($_) == 0) {
	$inp_state++;
	next;
    }
    if (index($_, ':') != -1) {
	next;
    }
    my @parts = split /\s\s+/;
    my %h = (Name => $parts[0], Cost => $parts[1], Damage => $parts[2], Armor => $parts[3]);
    if ($inp_state == 0) {
	push @weapons, {%h};
    } elsif ($inp_state == 1) {
	push @armor, {%h};
    } else {
	push @rings, {%h};
    }
}
push @armor, {Name => 'No Armor', Cost => 0, Damage => 0, Armor => 0};
push @rings, {Name => 'No Ring #1', Cost => 0, Damage => 0, Armor => 0};
push @rings, {Name => 'No Ring #2', Cost => 0, Damage => 0, Armor => 0};

sub wins {
    my %p1 = %{$_[0]};
    my %p2 = %{$_[1]};
    while ($p1{+HP} > 0) {
	$p2{+HP} -= max(1, $p1{'Damage'}-$p2{'Armor'});
	if ($p2{+HP} <= 0) {
	    return 1;
	}
	$p1{+HP} -= max(1, $p2{'Damage'}-$p1{'Armor'});
    }
    return 0;
}

sub search3 {
    my $sofar = shift;
    my $won = 0;
    my $best = 987654321;
    for (my $i = 0; $i < (scalar @rings); $i++) {
	for (my $j = $i + 1; $j < (scalar @rings); $j++) {
	    $player{Damage} += $rings[$i]{Damage} + $rings[$j]{Damage};
	    $player{Armor} += $rings[$i]{Armor} + $rings[$j]{Armor};
	    my $win = wins(\%player, \%boss);
	    if ($win) {
		$won = 1;
		$best = min($best, $sofar + $rings[$i]{Cost} + $rings[$j]{Cost});
	    }
	    $player{Damage} -= $rings[$i]{Damage} + $rings[$j]{Damage};
	    $player{Armor} -= $rings[$i]{Armor} + $rings[$j]{Armor};
	}
    }
    return ($won, $best);
}

sub search2 {
    my $sofar = shift;
    my $won = 0;
    my $best = 987654321;
    for my $a (@armor) {
	$player{'Armor'} += $$a{'Armor'};
	my ($win, $tot) = search3($sofar+$$a{'Cost'});
	if ($win) {
	    $won = 1;
	    $best = min($best, $tot);
	}
	$player{'Armor'} -= $$a{'Armor'};
    }
    return ($won, $best);
}
    

sub search1 {
    my $best = 987654321;
    for my $w (@weapons) {
	$player{'Damage'} += $$w{'Damage'};
	my ($win, $tot) = search2 $$w{'Cost'};
	if ($win) {
	    $best = min($best, $tot);
	}
	$player{'Damage'} -= $$w{'Damage'};
    }
    return $best;
}

say search1;
