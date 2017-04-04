use strict;
use warnings;

use Test::More;

use LDSQuiz::Types qw( InstanceOf PositiveInt SimpleStr);

ok( InstanceOf['DateTime'], 'Types::Standard' );
ok( PositiveInt, 'Types::Common::Numeric' );
ok( SimpleStr, 'Types::Common::String' );

done_testing();
