use strict;
use warnings;

use Test::More;

use LDSQuiz::Model ();

my $model = LDSQuiz::Model->new;
my $quiz = $model->quiz_for_id( 'intro', 0 );

ok( $quiz, 'quiz' );
my $question = $quiz->question;

ok( $question, 'question model' );
is( $question->answer,     0,                   'answer' );
is( $question->id,         'helen-mar-kimball', 'id' );
is( $question->input_type, 'radio',             'input_type' );
is_deeply( $question->options, [ 14 .. 17 ], 'options' );
is(
    $question->question,
    'How old was Helen Mar Kimball when she married Joseph Smith?',
    'question'
);

done_testing();
