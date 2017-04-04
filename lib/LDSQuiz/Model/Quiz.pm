package LDSQuiz::Model::Quiz;

use Moo;

use LDSQuiz::Model::Quiz::Question ();
use LDSQuiz::Types qw(
    ArrayRef
    Bool
    HashRef
    InstanceOf
    Maybe
    PositiveInt
    PositiveOrZeroInt
    Str
);

has _all_questions => (
    is      => 'ro',
    isa     => ArrayRef,
    lazy    => 1,
    default => sub { $_[0]->_config->{questions} },
);

has _config => (
    is       => 'ro',
    isa      => HashRef,
    init_arg => 'config',
    required => 1,
);

has id => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has is_complete => (
    is      => 'ro',
    isa     => Bool,
    lazy    => 1,
    default => sub { !$_[0]->next_position },
);

has next_position => (
    is      => 'ro',
    isa     => Maybe [PositiveInt],
    lazy    => 1,
    builder => '_build_next_position',
);

has position => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has question => (
    is      => 'ro',
    isa     => InstanceOf ['LDSQuiz::Model::Quiz::Question'],
    lazy    => 1,
    builder => '_build_question',
);

has size => (
    is      => 'ro',
    isa     => PositiveInt,
    lazy    => 1,
    default => sub { scalar @{ $_[0]->_all_questions } },
);

sub _build_next_position {
    my $self = shift;
    return $self->position < $self->size - 1
        ? $self->position + 1
        : undef;
}

sub _build_question {
    my $self = shift;
    return LDSQuiz::Model::Quiz::Question->new(
        $self->_config->{questions}->[ $self->position ] );
}

1;
