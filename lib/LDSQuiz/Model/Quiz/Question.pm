package LDSQuiz::Model::Quiz::Question;

use Moo;

use LDSQuiz::Types qw( ArrayRef Enum PositiveInt PositiveOrZeroInt Str );
use Path::Tiny qw( path );

has answer => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has answer_content => (
    is      => 'ro',
    isa     => Str,
    lazy    => 1,
    default => sub { $_[0]->options->[ $_[0]->answer ] },
);

has answer_discussion => (
    is   => 'ro',
    isa  => Str,
    lazy => 1,
    default =>
        sub { path( 'templates/html/answers', $_[0]->id . '.html' )->slurp },
);

has content => (
    is       => 'ro',
    isa      => Str,
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

1;
