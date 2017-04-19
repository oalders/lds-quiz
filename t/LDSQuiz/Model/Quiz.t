use strict;
use warnings;

use Test::More;

use LDSQuiz::Model ();

{
    my $model = LDSQuiz::Model->new(
        phase    => 'question',
        position => 0,
        quiz_id  => 'intro',
    );
    my $quiz = $model->quiz;

    is( $quiz->progress, 0, 'no progress' );
}

{
    my $model = LDSQuiz::Model->new( position => 0, quiz_id => 'intro', );
    my $quiz = $model->quiz;

    ok( $quiz, 'quiz' );
    is( $quiz->id,            'intro', 'quiz_id' );
    is( $quiz->next_position, 1,       'next_position' );
    is( $quiz->progress,      50,      'no progress' );
    is( $quiz->size,          2,       'size' );
    ok( !$quiz->is_complete, 'is_complete' );
    ok( $quiz->question,     'question' );
}

{
    my $model = LDSQuiz::Model->new(
        phase    => 'question',
        position => 1,
        quiz_id  => 'intro',
    );
    my $quiz = $model->quiz;
    is( $quiz->progress, 50, 'progress' );
    ok( $quiz->is_complete, 'is_complete' );
}

{
    my $model = LDSQuiz::Model->new(
        position => 1,
        quiz_id  => 'intro',
    );
    my $quiz = $model->quiz;
    is( $quiz->progress, 100, 'progress' );
    ok( $quiz->is_complete, 'is_complete' );
}
done_testing();
