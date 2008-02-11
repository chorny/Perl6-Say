#!/usr/local/bin/perl
#$Id: 02-bundle.pl 1209 2008-02-09 23:26:31Z jimk $
use strict;
use warnings;
use feature ':5.10.0';

say "say is available here";
{   
    no feature 'say';
    print "But not here.\n";
}   
say "Yet it is here.";

