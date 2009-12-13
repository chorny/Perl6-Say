#  !perl
#$Id: 01_stdout.t 1213 2008-02-09 23:40:34Z jimk $
# 01_stdout.t - basic tests of say()
use strict;
use warnings;
use Test::More tests => 16;
use lib ( qq{./t/lib} );
BEGIN {
    use_ok('Perl6::Say');
    use_ok('Carp');
    use_ok('Perl6::Say::Auxiliary', qw| _validate capture_say |);
};

SKIP: {
    eval qq{ require IO::Capture::Stdout; };;
    skip "tests require IO::Capture::Stdout", 
        13 if $@;

    my ($str, $say_sub, $msg);

    $say_sub = sub { say $str; };
    $msg = q{correctly printed to STDOUT as default print filehandle};

    $str = qq{Hello World};
    capture_say( {
        data => $str,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{Hello World\n};
    capture_say( {
        data => $str,
        pred => 2,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{Hello World\nAgain!\n};
    capture_say( {
        data => $str,
        pred => 3,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{};
    capture_say( {
        data => $str,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    $say_sub = sub { say STDOUT $str; };
    $msg = q{correctly printed to STDOUT as explicitly named print filehandle};

    $str = qq{Hello World};
    capture_say( {
        data => $str,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{Hello World\n};
    capture_say( {
        data => $str,
        pred => 2,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{Hello World\nAgain!\n};
    capture_say( {
        data => $str,
        pred => 3,
        eval => $say_sub,
        msg  => $msg,
    } );

    $str = qq{};
    capture_say( {
        data => $str,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    my ($capture, $cat);
    local $_ = qq{Hello World};
    $capture = IO::Capture::Stdout->new();
    $capture->start;
    say();
    $capture->stop;
    $cat = join q{}, $capture->read();
    is($cat, "$_\n",
        "1 line correctly printed from \$_");

    local $_ = qq{Hello World\n};
    $capture = IO::Capture::Stdout->new();
    $capture->start;
    say();
    $capture->stop;
    $cat = join q{}, $capture->read();
    is($cat, "$_\n",
        "2 lines correctly printed from \$_");

    local $_ = qq{};
    $capture = IO::Capture::Stdout->new();
    $capture->start;
    say();
    $capture->stop;
    $cat = join q{}, $capture->read();
    is($cat, "$_\n",
        "1 line correctly printed from \$_");

    $capture = IO::Capture::Stdout->new();
    $capture->start;
    say undef;
    $capture->stop;
    $cat = join q{}, $capture->read();
    is($cat, "\n",
        "1 line correctly printed where argument was 'undef'");

    $capture = IO::Capture::Stdout->new();
    $capture->start;
    say;
    $capture->stop;
    $cat = join q{}, $capture->read();
    is($cat, "\n",
        "1 line correctly printed where there were 0 arguments and no parens");
}

