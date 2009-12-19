#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Plack::Middleware::ScopeSession' ) || print "Bail out!
";
}

diag( "Testing Plack::Middleware::ScopeSession $Plack::Middleware::ScopeSession::VERSION, Perl $], $^X" );
