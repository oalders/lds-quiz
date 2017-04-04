use strict;
use warnings;

use Test::More;

use LDSQuiz::Model::Quiz::Score;

{
    my $score = get_model( [ 1, 1 ] );
    is( $score->score, 0, 'score' );
}

{
    my $score = get_model( [ 0, 1 ] );
    is( $score->score, 1, 'score' );
}

{
    my $score = get_model( [ 1, 0 ] );
    is( $score->score, 1, 'score' );
}

{
    my $score = get_model( [ 0, 0 ] );
    is( $score->score, 2, 'score' );
}

sub get_model {
    my $answers = shift;
    my $score   = LDSQuiz::Model::Quiz::Score->new(
        answers => $answers,
        quiz_id => 'intro',
    );
}

done_testing();
