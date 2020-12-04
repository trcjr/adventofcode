#!/usr/bin/env perl
use v5.29;


my $lines;
while(<>) {
    push @{$lines}, $_;
}

for my $a (@{$lines}) {
    for my $b (@{$lines}) {
        say "$a, $b " . $a * $b if $a + $b == 2020;
    }
}
