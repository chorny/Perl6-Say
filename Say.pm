package Perl6::Say;
use IO::Handle;
$VERSION = '0.02';

# Handle direct calls...

*{caller().'::say'} = sub { print @_, defined $\ ? "" : "\n" };

# Handle OO calls:

sub IO::Handle::say { my ($fh) = shift; print {$fh} @_, defined $\ ? "" : "\n" }

1;
__END__

=head1 NAME

Perl6::Say - Implements the Perl 6 C<say> (C<print>-with-newline) function


=head1 SYNOPSIS

    # Perl 5 code...

    use Perl6::Say;

    say 'boo';             # same as:  print 'boo', "\n"

    say STDERR 'boo';      # same as:  print STDERR 'boo', "\n"

    STDERR->say('boo');    # same as:  print STDERR 'boo', \n"

    $fh->say('boo');       # same as:  print $fh 'boo', "\n";


=head1 DESCRIPTION

Implements a close simulation of C<say>, the Perl 6 print-with-newline
function.

Use it just like C<print> (except that it only supports the indirect object
syntax when the stream is a bareword). That is, assuming the relevant
filehandles are open for output, you can use any of these:

    say @data;
    say FH @data;
    FH->say(@data);
    *FH->say(@data);
    (\*FH)->say(@data);
    $fh->say(@data);

but not any of these:

    say {FH} @data;
    say {*FH} @data;
    say {\*FH} @data;
    say $fh @data;
    say {$fh} @data;


=head2 Interaction with output record separator

In Perl 6, C<say> honours the output stream's output record separator.
That is, it only appends a newline if the output stream to which it's writing
doesn't have an output record separator defined:

    # Perl 6 code...

    say $FH: "boo";      # prints: "boo\n"

    $fh.ors = "\r";
    say $FH: "boo";      # prints: "boo\r"

To emulate this behaviour as best it can, C<Perl6::Say::say> prints
a newline after printing its arguments only if C<$\> is undefined. If C<$\>
is defined it prints the value in C<$\> after printing its arguments.

    # Perl 5 code...

    use Perl6::Say;

    say FH "boo";        # prints: "boo\n"

    local $\ = "\r";
    say FH "boo";        # prints: "boo\r"


=head1 WARNING

The syntax and semantics of Perl 6 is still being finalized
and consequently is at any time subject to change. That means the
same caveat applies to this module.


=head1 DEPENDENCIES

None.

=head1 AUTHOR

Damian Conway (damian@conway.org)


=head1 BUGS AND IRRITATIONS

As far as I can determine, Perl 5 doesn't allow us to create a subroutine
that truly acts like C<print>. That is, one that can simultaneously be
used like so:

    say @data;

and like so:

    say {$fh} @data;

Comments, suggestions, and patches welcome.


=head1 COPYRIGHT

 Copyright (c) 2004, Damian Conway. All Rights Reserved.
 This module is free software. It may be used, redistributed
    and/or modified under the same terms as Perl itself.
