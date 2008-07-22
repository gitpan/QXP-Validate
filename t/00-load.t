#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'QXP::Validate' );
}

diag( "Testing QXP::Validate $QXP::Validate::VERSION, Perl $], $^X" );
