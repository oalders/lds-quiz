package LDSQuiz::Model::Quiz::Score;

=pod

\ {
    answers => {
        intro => [
            [0] 0,
            [1] 1,
        ],
    },
}

=cut

use Moo;

use LDSQuiz::Model ();
use LDSQuiz::Types qw( ArrayRef Num PositiveInt PositiveOrZeroInt SimpleStr );
use List::AllUtils qw( pairwise );
use Math::Round qw( round );

has answers => (
    is       => 'ro',
    isa      => ArrayRef,
    required => 1,
);

has answer_key => (
    is      => 'ro',
    isa     => ArrayRef,
    lazy    => 1,
    builder => '_build_answer_key',
);

has out_of => (
    is      => 'ro',
    isa     => PositiveInt,
    lazy    => 1,
    default => sub {
        scalar @{ $_[0]->answer_key },
    },
);

has quiz_id => (
    is       => 'ro',
    isa      => SimpleStr,
    required => 1,
);

has percent => (
    is      => 'ro',
    isa     => PositiveOrZeroInt,
    lazy    => 1,
    default => sub { round( $_[0]->score / $_[0]->out_of * 100 ) },
);

has score => (
    is      => 'ro',
    isa     => Num,
    lazy    => 1,
    builder => '_build_score',
);

sub _build_answer_key {
    my $self   = shift;
    my $config = LDSQuiz::Model->new->config->{ $self->quiz_id };

    return [ map { $_->{answer} } @{ $config->{questions} } ];
}

sub _build_score {
    my $self  = shift;
    my $score = 0;
    my @pairs = pairwise { [ $a, $b ] } @{ $self->answer_key },
        @{ $self->answers };

    foreach my $pair (@pairs) {
        ++$score if defined $pair->[1] && $pair->[0] == $pair->[1];
    }

    return $score;
}

1;
