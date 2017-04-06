use strict;
use warnings;

use Test::More;

use LDSQuiz::Model ();

my $model = LDSQuiz::Model->new( position => 0, quiz_id => 'intro', );
my $quiz = $model->quiz;

ok( $quiz, 'quiz' );
is( $quiz->next_position, 1, 'next_position' );
is( $quiz->size,          2, 'size' );

done_testing();
