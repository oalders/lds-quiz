package LDSQuiz::Model;

use Moo;

use Cpanel::JSON::XS qw( decode_json );
use Path::Tiny qw( path );
use Types::Standard qw( HashRef );

has config => (
    is      => 'ro',
    isa     => HashRef,
    lazy    => 1,
    builder => '_build_config',
);

sub _build_config {
    my $self = shift;
    return decode_json( path('config.json')->slurp );
}

1;
