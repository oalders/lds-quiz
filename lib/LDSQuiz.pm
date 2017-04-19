package LDSQuiz;

use strict;
use warnings;

1;

__END__
# ABSTRACT: An LDS Church History Quiz that doesn't remove the interesting parts

=pod

=head1 INSTALLATION

You're encouraged to use cpanm in order to install the dependencies.  See L<https://metacpan.org/pod/App::cpanminus#INSTALLATION> for installation options.

    cpanm --installdeps .

    # Create HTML templates from the markdown files.  You'll need to run this
    # every time you add or update markdown.

    ./bin/convert-markdown.pl

    # start the app
    morbo app.pl

    # You can now view the app at http://127.0.0.1:3000/

=head1 TESTING

You can run the test suite via

    prove -lvr t

=head1 CONTRIBUTING

=head2 CONFIGURATION

Quizzes are configured in C<config.json>.  The keys are unique ids, one per
quiz.  If you'd like to add a new quiz or a new question, you can follow the
patterns in this file.

=head2 ANSWER TEMPLATES

Each question requires a corresponding answer file in
C<templates/markdown/answers/>.  The templates are in markdown format, you can
follow the format of one of the existing answer files when creating your own
answers.

The quiz is meant to be fun, but also educational.  For this reason, every
question requires some sort of discussion in the answer file.  All discussion
should have a neutral tone.  The point of the quiz is to relay facts and allow
the participant to draw her own conclusions.  You may include some questions
for further discussion as part of the answer.  This allows you an opportunity
to provide some context for the new information by suggesting points which
are worth considering.

=head3 SOURCES

Every answer needs accompanying sources which support the answer.  Primary
sources are to be preferred in all cases.  For example, basing the content of
your answer entirely on a Wikipedia article or a blog post is not acceptable.
Please make every effort to locate the original sources of the information
(Book of Mormon, Journal of Discourses, Mormon Doctrine, etc).  If your
discussion includes online content, it's appropriate to link to this content.
If your answer requires an image to be added to this repository it must be
either an image which you personally have the rights to or an image which has
been provided under the Creative Commons or similarly permissive license.

=head1 LICENSE

=head2 PERL

The Perl code in this repository is released under the same terms as Perl
itself.  See the accompanying LICENSE file for more details.

=head2 JAVASCRIPT AND CSS

For other files, like CSS and JavaScript, check the content of the file itself
to see which license it uses.

=head2 HTML TEMPLATE

If you intend to use this code to deploy your own site, you'll need to get your
own license.  License can be purchased at
L<https://wrapbootstrap.com/theme/the-project-multipurpose-template-WB0F82581>
Please note, if you're merely contributing and are firing up a local copy for
development purposes, you do not need to purchase a license.

=cut
