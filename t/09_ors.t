#  !perl
# 09_ors.t - test interaction with $\
use strict;
use warnings;
use Test::More 
tests =>  3;
# qw(no_plan);
use lib ( qq{./t/lib} );
BEGIN {
    use_ok('Perl6::Say');
    use_ok('Carp');
};

my $str = q{Hello World};
my $capture = q{};

open my $fh, ">>", \$capture or croak "Couldn't open string for appending";
my $oldfh = select $fh;
{
    local $\ = q{X};
    print "$str\n";
    say $str;
    say;
}
close $fh or croak "Couldn't close string after appending";
select $oldfh;

is($capture,
    qq{Hello World\nXHello World\nX\nX}, 
    "say() functioned as predicted with \$\\ (Output Record Separator)"
);

