use Test::More no_plan;
BEGIN { use_ok('Perl6::Say') };

say         'ok 2 - Just say it';
say STDOUT  'ok 3 - Say it indirectly ';
STDOUT->say('ok 4 - Say it directly');

Test::Builder->current_test(4);

my $str;
open FH, '>', \$str;

ok( (say FH 'what'), 					'Indirectly said:  "what"' );
is( $str, "what\n", 					'Indirectly heard: "what\n"' );

ok( (say FH "again\n"),					'Indirectly said:  "again\n"' );
is( $str, "what\nagain\n\n", 			'Indirectly heard: "again\n\n"' );

ok( (say FH 'onara'),					'Indirectly said:  "onara"' );
is( $str, "what\nagain\n\nonara\n", 	'Indirectly heard: "onara\n"' );

open FH, '>', \$str;
ok( (say FH "can\nyou\nsee"),	 		'Indirectly said:  "can\nyou\nsee"' );
is( $str, "can\nyou\nsee\n",	 		'Indirectly heard: "can\nyou\nsee\n"' );

open my $fh1, '>', \$str;

ok( $fh1->say('what'), 					'Directly said:  "what"' );
is( $str, "what\n", 					'Directly heard: "what\n"' );

ok( $fh1->say("again\n"),				'Directly said:  "again\n"' );
is( $str, "what\nagain\n\n", 			'Directly heard: "again\n\n"' );

ok( $fh1->say('onara'),					'Directly said:  "onara"' );
is( $str, "what\nagain\n\nonara\n", 	'Directly heard: "onara\n"' );


open my $fh2, '>', \$str;

ok( $fh2->say('what'), 					'Directly said:  "what"' );
is( $str, "what\n", 					'Directly heard: "what\n"' );

ok( $fh2->say("again\n"),				'Directly said:  "again\n"' );
is( $str, "what\nagain\n\n", 			'Directly heard: "again\n\n"' );

ok( $fh2->say('onara'),					'Directly said:  "onara"' );
is( $str, "what\nagain\n\nonara\n", 	'Directly heard: "onara\n"' );

close STDOUT;
open STDOUT, '>', \$str;

ok( (say 'what'),	 					'Simply said:  "what"' );
is( $str, "what\n", 					'Simply heard: "what\n"' );

ok( (say "again\n"),					'Simply said:  "again\n"' );
is( $str, "what\nagain\n\n", 			'Simply heard: "again\n\n"' );

ok( (say 'onara'),						'Simply said:  "onara"' );
is( $str, "what\nagain\n\nonara\n", 	'Simply heard: "onara\n"' );

close STDOUT;
open STDOUT, '>', \$str;

ok( (say "can\nyou\nsee"),	 			'Simply said:  "can\nyou\nsee"' );
is( $str, "can\nyou\nsee\n",	 		'Simply heard: "can\nyou\nsee\n"' );

close STDOUT;
open STDOUT, '>', \$str;
$\ = " [STOP] ";

ok( (say "ORS"),						'Said simply with ORS' );
is( $str, "ORS [STOP] ",				'Heard simply with ORS' );

undef $\;

close STDOUT;
open STDOUT, '>', \$str;
ok( (say "no ORS"),						'Said simply without ORS' );
is( $str, "no ORS\n",				 	'Heard simply without ORS' );

open $fh, '>', \$str;
$\ = " [STOP] ";

ok( ($fh->say("ORS")),					'Said methodically with ORS' );
is( $str, "ORS [STOP] ",				'Heard methodically with ORS' );

undef $\;

open $fh, '>', \$str;
ok( ($fh->say("no ORS")),				'Said methodically without ORS' );
is( $str, "no ORS\n",				 	'Heard methodically without ORS' );

