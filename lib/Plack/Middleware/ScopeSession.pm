package Plack::Middleware::ScopeSession;
use strict;
use warnings;
use ScopeSession;
use parent qw( Plack::Middleware );

our $VERSION = '0.01';

sub call {
    my ( $self, $env ) = @_;
    my $res;

    ScopeSession::start{
        my $session = shift;
        $session->set_option( 'psgi.env' => $env );
        $res = $self->app->($env);
    };
    return $res;
}
1;
=head1 NAME

Plack::Middleware::ScopeSession - Global Cache and Option per Request.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Plack::Middleware::ScopeSession works like mod_perl's pnotes.

    builder {
        enable q|Plack::Middleware::ScopeSession|
    } 

if enable this, give your application a per-request cache 

    use ScopeSession;

    sub something_in_your_application{
        ...
        my $env = ScopeSession->get_option('psgi.env');
        ScopeSession->notes( 'SingletonPerRequest' , Plack::Request->new($env));

    }

=head1 METHODS

=head2 call

=head1 SEE ALSO

L<ScopeSession>,L<Plack::Middleware>

=head1 AUTHOR

Daichi Hiroki, C<< <hirokidaichi<AT>gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Daichi Hiroki.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

