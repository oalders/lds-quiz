package LDSQuiz::Model;

use Moo;

use Cpanel::JSON::XS qw( decode_json );
use LDSQuiz::Model::Quiz        ();
use LDSQuiz::Model::Quiz::Score ();
use LDSQuiz::Types qw( HashRef InstanceOf PositiveOrZeroInt SimpleStr );
use Path::Tiny qw( path );

has config => (
    is      => 'ro',
    isa     => HashRef,
    lazy    => 1,
    builder => '_build_config',
);

has position => (
    is  => 'ro',
    isa => PositiveOrZeroInt,
);

has quiz => (
    is      => 'ro',
    isa     => InstanceOf ['LDSQuiz::Model::Quiz'],
    lazy    => 1,
    builder => '_build_quiz',
);

has quiz_id => (
    is  => 'ro',
    isa => SimpleStr,
);

has session => (
    is  => 'ro',
    isa => HashRef,
);

has score => (
    is      => 'ro',
    isa     => InstanceOf ['LDSQuiz::Model::Quiz::Score'],
    lazy    => 1,
    builder => '_build_score',
);

sub _build_config {
    my $self = shift;
    return decode_json( path('config.json')->slurp );
}

sub _build_score {
    my $self = shift;
    return LDSQuiz::Model::Quiz::Score->new(
        answers => $self->session->{answers}->{ $self->quiz_id },
        quiz_id => $self->quiz_id,
    );
}

sub _build_quiz {
    my $self = shift;

    return LDSQuiz::Model::Quiz->new(
        config   => $self->config->{ $self->quiz_id },
        id       => $self->quiz_id,
        position => $self->position,
    );
}

1;
