#!/usr/bin/env perl

use strict;
use warnings;
use feature qw( say );

use Path::Tiny qw( path );
use Text::Markdown qw( markdown );

path('templates/html/answers')->mkpath;

my @templates = glob('templates/markdown/answers/*.md');

foreach my $file (@templates) {
    my $content = path($file)->slurp;

    my $html_file_path = $file;
    $html_file_path =~ s{markdown}{html};
    $html_file_path =~ s{\.md}{.html};

    path($html_file_path)->spew( markdown($content) );
    say "Created/updated $html_file_path";
}

# PODNAME: convert-markdown.pl
# ABSTRACT: convert markdown files to HTML
