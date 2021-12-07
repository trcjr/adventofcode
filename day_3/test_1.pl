#!/usr/bin/perl
use v5.29;
use Data::Dumper;
use Test::Most;
use lib '.';

require "main_1.pl";

my $testMap = <<END;
..##.......
#...#...#..
#.#....#..#.
#..#.#...#.#
#.#...##..#.
#..#.##.....
#.#.#.#....#
#.#........#
##.##...#...
##...##....#
#.#..#...#.#
END

{    # parse_line
    my $testCases = [
        {   have => $testMap,
            want => 7,
        },
    ];

    for my $testCase ( @{$testCases} ) {
        my $have = $testCase->{have};
        my $want = $testCase->{want};
        is ( run_map( $have ), $want, "run_map " . $have );
    }
}

done_testing();
