#!/usr/bin/env perl
use v5.29;


my $lines;
while(<>) {
    chomp;
    push @{$lines}, $_;
}

=pod
This is the solution for Day 1 Problem 1
=cut

for my $a (@{$lines}) {
    for my $b (@{$lines}) {
        for my $b (@{$lines}) {
        say "$a, $b " . $a * $b if $a + $b == 2020;
    }
}

=pod
This is the solution for Day 1 Problem 2
=cut

for my $a (@{$lines}) {
    for my $b (@{$lines}) {
        for my $c (@{$lines}) {
            say "$a, $b, $c == " . $a * $b * $c if $a + $b + $c == 2020;
        }
    }
}
