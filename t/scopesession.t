use strict;
use warnings;
use Test::More tests => 18;

use HTTP::Request::Common;
use Plack::Test;
use Plack::Middleware::ScopeSession;
use ScopeSession;
use ScopeSession::Singleton;
{
    package Test::Ob;
    sub new{ bless {},shift};
    sub DESTROY{
        ::pass('call-destroy');
    }
}


test_psgi 
    app => Plack::Middleware::ScopeSession->wrap(sub {
        my $env = shift;
        ::ok( ScopeSession->is_started );
        ::is( ScopeSession->notes('hello'), undef );
        ::ok( ScopeSession->notes( hello => q|world| ) );
        ::is( ScopeSession->notes('hello'), q|world| );
        ScopeSession->notes( 'just destroy' => Test::Ob->new );
        ::is_deeply( $env , ScopeSession->get_option( 'psgi.env' ));
        return [ 200, [ 'Content-Type' => 'text/plain' ], ["Hello World"] ];
    }),
    client => sub {
        my $cb = shift;
        for(1..3){
            my $req = HTTP::Request->new( GET => "http://localhost/hello" );
            my $res = $cb->($req);
        }

    };
