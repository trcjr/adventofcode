#!/usr/bin/perl
use v5.29;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

sub parse_line {
    my $line   = shift;
    my $result = {};
    $result->{line} = $line;
    my ( $min, $max, $char, $password ) = $line =~ /^([0-9]+)-([0-9]+)\s([a-z]):\s(.*)/;

    $result->{min}       = $min;
    $result->{max}       = $max;
    $result->{character} = $char;
    $result->{password}  = $password;
    return $result;
}

sub check_line_valid {
    my $line   = shift;
    my $result = {};
    $result->{line}  = $line;
    $result->{error} = [];

    my $parsed_line_result = parse_line( $line );
    $result->{parsed_line_result} = $parsed_line_result;

    my $character = $parsed_line_result->{character};
    my $min       = $parsed_line_result->{min};
    my $max       = $parsed_line_result->{max};
    my $password  = $parsed_line_result->{password};

    # check the counts
    my @matches = $password =~ /($character)/g;
    my $matches = scalar @matches;

    push @{ $result->{error} }, "min" if ( $matches < $min );
    push @{ $result->{error} }, "max" if ( $matches > $max );

    $result->{es}            = 'sdf';
    $result->{matches}       = \@matches;
    $result->{matches_count} = $matches;

    #warn Dumper $result;
    return scalar @{ $result->{error} } == 0 ? 1 : 0;
} ## end sub check_line_valid

unless ( caller ) {    # basically main

    my $data = {};
    while ( <STDIN> ) {
        chomp;
        my $result = check_line_valid( $_ );
        $data->{$result}++;
    }
    say Dumper $data;
}
