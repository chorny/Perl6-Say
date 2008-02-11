#!/usr/local/bin/perl
#$Id: 03-implicit.pl 1210 2008-02-09 23:28:00Z jimk $
use strict;
use warnings;
use 5.010;

say "say is available here";
{   
    no feature 'say';
    print "But not here.\n";
}   
say "Yet it is here.";

