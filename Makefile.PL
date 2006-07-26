use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => q[Perl6::Say],
    VERSION_FROM    => q[lib/Perl6/Say.pm],
    ABSTRACT        => q['print' -- but no newline needed],
    AUTHOR          => q[James E Keenan (jkeenan@cpan.org)],
    PREREQ_PM    => {
        Test::More      => 0.44,
        IO::Handle      => 0,       # in the Perl core
        Scalar::Util    => 1.07,    # in the Perl core since 5.007003
        Carp            => 0,       # in the Perl core
    }
);
