#!/usr/bin/env perl

use Mojolicious::Lite;

use lib 'lib';
use LDSQuiz::Model ();

get '/' => sub {
    my $c = shift;
    $c->render( template => 'index' );
};

get '/quiz/:id' => sub {
    my $c = shift;

    state $model = LDSQuiz::Model->new;
    my $position = $c->param('position') || 0;
    my $quiz = $model->quiz_for_id( $c->param('id'), $position )
        || return $c->not_found;

    $c->stash( quiz => $quiz );

    return _answer($c) if defined $c->param('answer');

    $c->render( template => 'quiz' );
} => 'quiz';

sub _answer {
    my $c = shift;
    $c->render( template => 'answer' );
}

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h1>Test Your Knowledge of LDS Church History</h1>

<a href="/quiz/intro">Take the introductory quiz</a>

@@ quiz.html.ep
% layout 'default';
% title 'Quiz';
Question: <%= $quiz->question->content %>

<form method="GET">
%= hidden_field position => $quiz->position
% my $i = 0;
% for my $option ( @{$quiz->question->options} ) {
<p>
<%= $quiz->question->input_type eq 'radio' ? radio_button( answer => $i ) : check_box( answer => $i) %>
<%= $option %>
</p>
%      ++$i;
% }
%= submit_button
</form>

@@ answer.html.ep
% layout 'default';
% title 'Quiz';
% my $answer = param('answer');

<p>Question: <%= $quiz->question->content %></p>
<p>Your answer: <%= $quiz->question->options->[ $answer ] %></p>

% my $correct = $answer == $quiz->question->answer;

<p>This is: <%= $correct ? 'correct' : 'incorrect' %></p>

% unless ( $correct ) {
    <p>The correct answer is: <%= $quiz->question->answer_content %></p>
% }

<%== $quiz->question->answer_discussion %>

% if ( $quiz->next_position ) {
<p>
<a href="<%= url_for('quiz')->query([position => $quiz->next_position]) %>">
Next question
</a>
</p>
% }
% else {
    <p>Quiz complete.</p>
% }

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
