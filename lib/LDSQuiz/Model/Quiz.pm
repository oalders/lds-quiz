package LDSQuiz::Model::Quiz;

use Moo;

use LDSQuiz::Model::Quiz::Question ();
use LDSQuiz::Types qw(
    ArrayRef
    Bool
    Enum
    HashRef
    InstanceOf
    Maybe
    PositiveInt
    PositiveOrZeroInt
    SimpleStr
    Str
);
use Math::Round qw( round );

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

has name => (
    is      => 'ro',
    isa     => SimpleStr,
    lazy    => 1,
    default => sub { $_[0]->_config->{name} },
);

has next_position => (
    is      => 'ro',
    isa     => Maybe [PositiveInt],
    lazy    => 1,
    builder => '_build_next_position',
);

has phase => (
    is        => 'ro',
    isa       => Enum [ 'answer', 'question' ],
    predicate => '_has_phase',
);

has position => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has progress => (
    is      => 'ro',
    isa     => PositiveOrZeroInt,
    lazy    => 1,
    builder => '_build_progress',
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

sub _build_progress {
    my $self = shift;
    return round(
        (
              $self->_has_phase && $self->phase eq 'question'
            ? $self->position
            : $self->position + 1
        ) / $self->size * 100
    );
}

sub _build_question {
    my $self = shift;
    return LDSQuiz::Model::Quiz::Question->new(
        $self->_config->{questions}->[ $self->position ] );
}

1;
