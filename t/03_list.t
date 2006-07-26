#  !perl
# 03_list.t - test what happens when passing list to say
use strict;
use warnings;
use Test::More 
tests => 11;
# qw(no_plan);
use lib ( qq{./t/lib} );
BEGIN {
    use_ok('Perl6::Say');
    use_ok('Carp');
    use_ok('Perl6::Say::Auxiliary', qw| _validate capture_say |);
};

SKIP: {
    eval qq{ require IO::Capture::Stdout; };;
    skip "tests require IO::Capture::Stdout", 
        8 if $@;

    my (@list, $say_sub, $msg);

    $say_sub = sub { say @list; };
    $msg = q{correctly printed to STDOUT as default print filehandle};

    @list = ( 'Hello', ' ', 'World' );
    capture_say( {
        data => \@list,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = ( 'Hello', ' ', 'World', "\n" );
    capture_say( {
        data => \@list,
        pred => 2,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
    capture_say( {
        data => \@list,
        pred => 3,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = (  );
    capture_say( {
        data => \@list,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );


    $say_sub = sub { say STDOUT @list; };
    $msg = q{correctly printed to STDOUT as explicitly named print filehandle};

    @list = ( 'Hello', ' ', 'World' );
    capture_say( {
        data => \@list,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = ( 'Hello', ' ', 'World', "\n" );
    capture_say( {
        data => \@list,
        pred => 2,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
    capture_say( {
        data => \@list,
        pred => 3,
        eval => $say_sub,
        msg  => $msg,
    } );

    @list = (  );
    capture_say( {
        data => \@list,
        pred => 1,
        eval => $say_sub,
        msg  => $msg,
    } );
}

