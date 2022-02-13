#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util qw( min max );
use Clone 'clone';

use constant HP => 'hit point';

my %player = (HP() => 50, damage => 0, armor => 0, mana => 500, shield => 0, poison => 0, recharge => 0);
my %boss = ();

open my $fh, '<', "input"
    or die "Can't open file: $!";
while (<$fh>) {
    chomp;
    my @parts = split /: /;
    if ($parts[0] eq 'Hit Points') {
	$boss{+HP} = int($parts[1]);
    } else {
	$boss{damage} = int($parts[1]);
    }
}

sub state_to_s {
    my %p = %{$_[0]};
    my $res = '';
    for my $k (sort (keys %p)) {
	my $v = $p{$k};
	$res = $res . $k . ':' . $v . ',';
    }
    return $res;
}


sub effect {
    my ($p, $b) = @_;
    # Shield effect
    if ($$p{shield} > 0) {
	$$p{shield} -= 1;
	$$p{armor} = 7;
    } else {
	$$p{armor} = 0;
    }
    # Poison effect
    if ($$p{poison} > 0) {
	$$p{poison} -= 1;
	$$b{+HP} -= 3;
    }
    # Recharge effect
    if ($$p{recharge} > 0) {
	$$p{recharge} -= 1;
	$$p{mana} += 101;
    }
}

my %memo = ();
sub solve1 {
    my %p = %{$_[0]};
    my %b = %{$_[1]};
    my $s = (state_to_s \%p) . ';' . (state_to_s \%b);
    # say $s;
    if (defined $memo{$s}) {
	return $memo{$s};
    }
    my $res = 987654321;
    my @a = ();
    effect(\%p, \%b);
    # Magic Missile    
    if ($p{mana} >= 53) {
	my %pp = %{clone(\%p)};
	my %bb = %{clone(\%b)};
	$pp{mana} -= 53;
	$bb{+HP} -= 4;
	effect(\%pp, \%bb);
	if ($bb{+HP} <= 0) {
	    push @a, 53;
	} else {
	    $pp{+HP} -= max(1, $b{damage}-$pp{armor});
	    if ($pp{+HP} > 0) {
		push @a, 53 + solve1(\%pp, \%bb);
	    }
	}
    }
    # Drain
    if ($p{mana} >= 73) {
	my %pp = %{clone(\%p)};
	my %bb = %{clone(\%b)};
	$pp{mana} -= 73;
        $bb{+HP} -= 2;
	$pp{+HP} += 2;
	effect(\%pp, \%bb);
        if ($bb{+HP} <= 0) {
            push @a, 73;
        } else {
            $pp{+HP} -= max(1, $b{damage}-$pp{armor});
            if ($pp{+HP} > 0) {
                push @a, 73 + solve1(\%pp, \%bb);
            }
        }
    }
    # Shield
    if ($p{mana} >= 113 and $p{shield} <= 0) {
	my %pp = %{clone(\%p)};
	my %bb = %{clone(\%b)};
	$pp{mana} -= 113;
	$pp{shield} = 6;
	effect(\%pp, \%bb);
	if ($bb{+HP} <= 0) {
	    push @a, 113;
	}  else {
	    $pp{+HP} -= max(1, $b{damage}-$pp{armor});
	    if ($pp{+HP} > 0) {
		push @a, 113 + solve1(\%pp, \%bb);
	    }
	}
    }
    # Poison
    if ($p{mana} >= 173 and $p{poison} <= 0) {
	my %pp = %{clone(\%p)};
	my %bb = %{clone(\%b)};
        $pp{mana} -= 173;
	$pp{poison} = 6;
	effect \%pp, \%bb;
     	if ($bb{+HP} <= 0) {
	    push @a, 173;
	} else {
	    $pp{+HP} -= max(1, $b{damage}-$pp{armor});
            if ($pp{+HP} > 0) {
                push @a, 173 + solve1(\%pp, \%bb);
	    }
        }
    }
    # Recharge
    if ($p{mana} >= 229 and $p{recharge} <= 0) {
	my %pp = %{clone(\%p)};
	my %bb = %{clone(\%b)};
	$pp{mana} -= 229;
	$pp{recharge} = 5;
	effect(\%pp, \%bb);
	if ($bb{+HP} <= 0) {
	    push @a, 229;
	} else {
	    $pp{+HP} -= max(1, $b{damage}-$pp{armor});
	    if ($pp{+HP} > 0) {
		push @a, 229 + solve1(\%pp, \%bb);
	    }
	}
    }
    for my $x (@a) {
	$res = min($res, $x);
    }
    $memo{$s} = $res;
    return $res;
}

say solve1(\%player, \%boss);
