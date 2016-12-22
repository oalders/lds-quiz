package LDSQuiz::Model::Quiz::Question;

use Moo;

use Types::Common::Numeric qw( PositiveInt PositiveOrZeroInt );
use Types::Standard qw( ArrayRef Enum Str );

has answer => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has id => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has input_type => (
    is      => 'ro',
    isa     => Enum( [ 'checkbox', 'radio' ] ),
    default => 'checkbox',
);

has options => (
    is       => 'ro',
    isa      => ArrayRef,
    required => 1,
);

has question => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

1;
