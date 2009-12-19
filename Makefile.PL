use inc::Module::Install;

name     'Plack-Middleware-ScopeSession';
all_from 'lib/Plack/Middleware/ScopeSession.pm';
author   q{Daichi Hiroki <hirokidaichi<AT>gmail.com>};
license  'perl';

for(qw/
    Test::More
    Test::Exception
    Plack::Test
/){
    build_requires $_;
}

for(qw/
    parent
    Plack::Middleware
    ScopeSession
    HTTP::Request::Common
/){
    requires $_;
}

auto_install;

WriteAll;

