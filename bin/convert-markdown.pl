#!/usr/bin/env perl

use strict;
use warnings;
use feature qw( say );

use Path::Tiny qw( path );

path('templates/html/answers')->mkpath;

my @templates = glob('templates/markdown/answers/*.md');

foreach my $file (@templates) {
    my $html_file_path = $file;
    $html_file_path =~ s{markdown}{html};
    $html_file_path =~ s{\.md}{.html};

    my @args = ( 'pandoc', '-f', 'markdown', '-t', 'html', $file, '-o', $html_file_path);
    system( @args );

    # pandoc inserts a UTF-8 character which appears to get double encoded when
    # Mojo spits it out.  Just use an HTML entity rather than trying to figure
    # this out.
    `perl -pi -e 's/↩/&#8617;/gc' $html_file_path`;
    say "Created/updated $html_file_path";
}


# PODNAME: convert-markdown.pl
# ABSTRACT: convert markdown files to HTML
