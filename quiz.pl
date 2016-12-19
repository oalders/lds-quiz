#!/usr/bin/env perl

use Mojolicious::Lite;

use lib 'lib';
use LDSQuiz::Model ();

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

get '/quiz/:id' => sub {
  my $c = shift;
  state $model = LDSQuiz::Model->new;
  state $config = LDSQuiz::Model->new->config;
  my $quiz = $config->{$c->param('id')} || return $c->not_found;
  my $question = $c->param('question') || 1;
  $c->stash( question_number => $question );
  $c->stash( q => $quiz->{questions}->[$question -1] );
  $c->stash( quiz => $quiz );
  $c->render(template => 'quiz');
};

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
Question: <%= $q->{question} %>

% for my $option ( @{$q->{options}} ) {
%      state $i = 0;
<p>
<%= $q->{input_type} eq 'radio' ? radio_button( answer => $i ) : check_box( answer => $i) %>
<%= $option %>
</p>
%      ++$i;
% }


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
