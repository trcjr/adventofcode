#!/usr/bin/perl
use v5.29;
use Data::Dumper;
use Test::Most;
use lib '.';

require "main.pl";

=cut
1-3 a: abcde
1-3 a: abcde


<lowest number of character to pass>-<highest number of character to pass> <character>: <password>
=cut

{    # parse_line
    my $testCases = [
        {   have => "1-3 a: abcde",
            want => {
                line      => "1-3 a: abcde",
                min       => 1,
                max       => 3,
                character => "a",
                password  => "abcde",
            },
        },
        {   have => "1-3 b: cdefg",
            want => {
                line      => "1-3 b: cdefg",
                min       => 1,
                max       => 3,
                character => "b",
                password  => "cdefg",
            },
        },
        {   have => "2-9 c: ccccccccc",
            want => {
                line      => "2-9 c: ccccccccc",
                min       => 2,
                max       => 9,
                character => "c",
                password  => "ccccccccc",
            },
        },
    ];

    for my $testCase ( @{$testCases} ) {
        my $have = $testCase->{have};
        my $want = $testCase->{want};
        cmp_deeply( parse_line( $have ), $want, "parse_line: " . $have );
    }
}

{    # check_line_valid
    my $testCases = [
        {   have => "1-3 a: abcde",
            want => 1,
        },
        {   have => "1-3 b: cdefg",
            want => 0,
        },
        {   have => "2-9 c: ccccccccc",
            want => 1,
        },
    ];

    for my $testCase ( @{$testCases} ) {
        my $have = $testCase->{have};
        my $want = $testCase->{want};
        is( check_line_valid( $have ), $want, "check_line_valid: " . $have );
    }
}

done_testing();
