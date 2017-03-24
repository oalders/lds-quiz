package LDSQuiz::Model;

use Moo;

use Cpanel::JSON::XS qw( decode_json );
use LDSQuiz::Model::Quiz ();
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

sub quiz_for_id {
    my $self     = shift;
    my $id       = shift;
    my $position = shift;

    return LDSQuiz::Model::Quiz->new(
        config   => $self->config->{$id},
        id       => $id,
        position => $position,
    );
}

1;
