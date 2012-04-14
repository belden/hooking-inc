#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use ForceToHead;
use Data::Dumper;

my @array = (2..10);
tie @array, 'ForceToHead', 'a', @array;

unshift @array, 1;
is_deeply( \@array, ['a',1..10] ) or warn Dumper [@array];

shift @array;
is_deeply( \@array, ['a',2..10]);

push @array, 11;
is_deeply( \@array, ['a',2..11]);

pop @array;
is_deeply( \@array, ['a',2..10]);

splice @array, 0, 3;
is_deeply( \@array, ['a',2..3] );
