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

    my $parsed_line_result = parse_line( $line );
    $result->{parsed_line_result} = $parsed_line_result;

    my $character       = $parsed_line_result->{character};
    my $first_position  = $parsed_line_result->{min};
    my $second_position = $parsed_line_result->{max};
    my $password        = $parsed_line_result->{password};

    my @chars;
    push @chars, substr( $password, $first_position-1, 1);
    push @chars, substr( $password, $second_position-1, 1);

    my $x = grep { /$character/ } @chars;

    $result->{char_c} = $x;
    $result->{chars} = \@chars;
    my @matches = $password =~ /($character)/g;
    my $matches = scalar @matches;


    $result->{es}            = 'sdf';
    $result->{matches}       = \@matches;
    $result->{matches_count} = $matches;

    #warn Dumper $result;
    #return grep { /$character/ } @chars == 01 ? "cat" : "dog";
    return $x == 1 ? 1 : 0;
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
