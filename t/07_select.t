#  !perl
# 07_select.t - test say() when select is called after filehandle is opened
use strict;
use warnings;
use Test::More 
tests => 19;
# qw(no_plan);
use lib ( qq{./t/lib} );
BEGIN {
    use_ok('Perl6::Say');
    use_ok('Carp');
    use_ok('Perl6::Say::Auxiliary', qw| _validate capture_say_scalar |);
};

my %diagnostics = (
    open    => qq{Cannot open filehandle to scalar ref for writing},
    close   => qq{Cannot close filehandle to scalar ref after writing},
);

my ($say_sub, $msg, @list);

##### Global Filehandle:  Direct #####

$say_sub = sub {
    my $arg = shift;
    my $string = q{};
    open FH, ">", \$string or croak $diagnostics{open};
    select(FH);
    ref($arg eq q{ARRAY}) ? say @{$arg} : say $arg;
    close FH or croak $diagnostics{close};
    return $string;
};
$msg= q{correctly printed to string via global filehandle, selected};

@list = ( 'Hello', ' ', 'World' );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_scalar( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_scalar( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Global Filehandle: Arrow  #####

$say_sub = sub {
    my $arg = shift;
    my $string = q{};
    open FH, ">", \$string or croak $diagnostics{open};
    select(FH);
    ref($arg eq q{ARRAY}) ? say @{$arg} : say $arg;
    close FH or croak $diagnostics{close};
    return $string;
};
$msg= q{correctly printed to string via global filehandle, selected, arrow syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_scalar( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_scalar( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Lexical Filehandle:  Comma  #####

$say_sub = sub {
    my $arg = shift;
    my $string = q{};
    open my $fh, ">", \$string or croak $diagnostics{open};
    select($fh);
    ref($arg eq q{ARRAY}) ? say @{$arg} : say $arg;
    close $fh or croak $diagnostics{close};
    return $string;
};
$msg= q{correctly printed to string via lexical filehandle, selected, comma syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_scalar( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_scalar( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Lexical Filehandle:  Arrow #####

$say_sub = sub {
    my $arg = shift;
    my $string = q{};
    open my $fh, ">", \$string or croak $diagnostics{open};
    select($fh);
    ref($arg eq q{ARRAY}) ? say @{$arg} : say $arg;
    close $fh or croak $diagnostics{close};
    return $string;
};
$msg= q{correctly printed to string via lexical filehandle, selected, arrow syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_scalar( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_scalar( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_scalar( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

