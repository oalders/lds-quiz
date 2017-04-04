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
use LDSQuiz::Types qw( ArrayRef Num SimpleStr );
use List::AllUtils qw( pairwise );

has answers => (
    is       => 'ro',
    isa      => ArrayRef,
    required => 1,
);

has config => (
    is   => 'ro',
    isa  => ArrayRef,
    lazy => 1,
    default =>
        sub { LDSQuiz::Model->new->config->{ $_[0]->quiz_id }->{questions} },
);

has quiz_id => (
    is       => 'ro',
    isa      => SimpleStr,
    required => 1,
);

has score => (
    is      => 'ro',
    isa     => Num,
    lazy    => 1,
    builder => '_build_score',
);

sub _build_score {
    my $self       = shift;
    my $score      = 0;
    my @answer_key = map { $_->{answer} } @{ $self->config };
    my @pairs      = pairwise { [ $a, $b ] } @answer_key, @{ $self->answers };

    foreach my $pair (@pairs) {
        ++$score if defined $pair->[1] && $pair->[0] == $pair->[1];
    }

    return $score;
}

1;
