use strict;
use warnings;

use DDP;
use Test::Mojo;
use Test::More;

require 'app.pl';

my $t  = Test::Mojo->new;
my $tx = $t->get_ok('/')->status_is(200);

my $links = $t->tx->res->dom->find('a')
    ->grep( sub { $_->text =~ m{introductory quiz}i } );

is ( @{$links}, 1, 'found link to quiz' );

$t->get_ok( $links->[0]->attr->{href} )->status_is(200)
    ->content_like(qr{Helen Mar Kimball}i);

done_testing();
