#  !perl
# 04_file_list.t - test say() when printing lists via filehandle to file
use strict;
use warnings;
use Test::More 
tests => 28;
# qw(no_plan);
use lib ( qq{./t/lib} );
BEGIN {
    use_ok('Perl6::Say');
    use_ok('File::Temp');
    use_ok('Carp');
    use_ok('Perl6::Say::Auxiliary', qw| _validate capture_say_file |);
};

my ($say_sub, $msg, @list);

##### Global Filehandle:  Direct #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open FH, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? say FH @{$arg} : say FH $arg;
    close FH or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via global filehandle};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Global Filehandle: Arrow  #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open FH, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? FH->say(@{$arg}) : FH->say($arg);
    close FH or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via global filehandle, arrow syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Global Filehandle: Typeglob  #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open FH, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? *FH->say(@{$arg}) : *FH->say($arg);
    close FH or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via global filehandle, typeglob syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Global Filehandle: Reference to Typeglob  #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open FH, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? (*FH)->say(@{$arg}) : (*FH)->say($arg);
    close FH or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via global filehandle, ref to typeglob syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );


##### Lexical Filehandle:  Comma  #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open my $fh, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? say $fh, @{$arg} : say $fh, $arg;
    close $fh or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via lexical filehandle, comma syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

##### Lexical Filehandle:  Arrow #####

$say_sub = sub {
    my ($tmpfile, $arg) = @_;
    open my $fh, ">$tmpfile" or croak "Cannot open tempfile for writing";
    ref($arg eq q{ARRAY}) ? $fh->say(@{$arg}) : $fh->say($arg);
    close $fh or croak "Cannot close tempfile after writing";
};
$msg= q{correctly printed to file via lexical filehandle, arrow syntax};

@list = ( 'Hello', ' ', 'World' );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n" );
capture_say_file( {
    data => \@list, pred => 2, eval => $say_sub, msg  => $msg,
} );

@list = ( 'Hello', ' ', 'World', "\n", 'Again!', "\n" );
capture_say_file( {
    data => \@list, pred => 3, eval => $say_sub, msg  => $msg,
} );

@list = (  );
capture_say_file( {
    data => \@list, pred => 1, eval => $say_sub, msg  => $msg,
} );

