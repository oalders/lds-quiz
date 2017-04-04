package LDSQuiz::Types;

use strict;
use warnings;

use Type::Library -base;
use Type::Tiny;
use Type::Utils -all;

BEGIN { extends "Types::Common::Numeric" }
BEGIN { extends "Types::Common::String" }
BEGIN { extends "Types::Standard" }

1;
