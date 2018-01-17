requires "Cpanel::JSON::XS" => "0";
requires "List::AllUtils" => "0";
requires "Math::Round" => "0";
requires "Mojolicious", "7.60";
requires "Moo" => "0";
requires "Path::Tiny" => "0";
requires "Text::Markdown" => "0";
requires "Type::Library" => "0";
requires "Type::Tiny" => "0";
requires "Type::Utils" => "0";
requires "Types::Common::Numeric" => "0";
requires "Types::Common::String" => "0";
requires "Types::Standard" => "0";
requires "feature" => "0";
requires "perl" => "5.013010";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "DDP" => "0";
  requires "Test::Mojo" => "0";
  requires "Test::More" => "0";
  requires "perl" => "5.013010";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "perl" => "5.013010";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::Code::TidyAll" => "0.50";
  requires "Test::More" => "0.88";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Spelling" => "0.12";
  requires "Test::Synopsis" => "0";
};
