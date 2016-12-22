use strict;
use warnings;

use LDSQuiz::Model;
use Test::More;

my $model = LDSQuiz::Model->new;
ok( $model->config, 'config' );

done_testing();
