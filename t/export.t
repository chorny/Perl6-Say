#!/usr/bin/perl -w

# Check that Perl6::Say exports properly.  It didn't.

use Test::More tests => 2;


package Foo;
use Perl6::Say;

::can_ok 'Foo', 'say';


package Bar;
use Perl6::Say;

::can_ok 'Bar', 'say';
