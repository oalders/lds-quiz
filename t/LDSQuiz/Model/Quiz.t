use strict;
use warnings;

use Test::More;

use LDSQuiz::Model ();

my $model = LDSQuiz::Model->new;
my $quiz = $model->quiz_for_id( 'intro', 0 );

ok( $quiz, 'quiz' );
is( $quiz->next_position, 1, 'next_position' );
is( $quiz->size,          2, 'size' );

done_testing();
