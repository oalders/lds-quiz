#!/usr/bin/env perl

use Mojolicious::Lite;

use lib 'lib';
use LDSQuiz::Model ();

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
    my $c = shift;
    $c->render( template => 'index' );
};

get '/quiz/:id' => sub {
    my $c = shift;

    state $model  = LDSQuiz::Model->new;
    state $config = LDSQuiz::Model->new->config;
    my $position = $c->param('position') || 0;
    my $quiz
        = $model->quiz_for_id( $c->param('id'), $position  )
        || return $c->not_found;

    $quiz->questions;
    $quiz->size;
    $c->stash( quiz     => $quiz );

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
Question: <%= $quiz->question %>

<form method="GET">
%= hidden_field position => $quiz->position
% my $i = 0;
% for my $option ( @{$q->{options}} ) {
<p>
<%= $q->{input_type} eq 'radio' ? radio_button( answer => $i ) : check_box( answer => $i) %>
<%= $option %>
</p>
%      ++$i;
% }
%= submit_button
</form>

@@ answer.html.ep
% layout 'default';
% title 'Quiz';
Question: <%= $q->{question} %>
Answer: <%= param('answer') == $q->{answer} ? 'correct' : 'incorrect' %>

% use DDP;
% p $quiz;

% if ( $quiz->next_position ) {
<a href="<%= url_for('quiz')->query([position => $quiz->next_position]) %>">
Next question
</a>
% }
% else {
    Quiz complete.
% }

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
