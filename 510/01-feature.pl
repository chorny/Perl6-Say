#!/usr/local/bin/perl
#$Id: 01-feature.pl 1207 2008-02-09 23:22:29Z jimk $
use strict;
use warnings;

{   
    use feature 'say';
    say "say is available here";
}   
print "But not here.\n";
print "\n";

use feature 'say';
say "say is available here";
{   
    no feature 'say';
    print "But not here.\n";
}   
say "Yet it is here.";


