#!/usr/bin/env perl

use Mojolicious::Lite;

use lib 'lib';

use LDSQuiz::Model              ();
use LDSQuiz::Model::Quiz::Score ();
use Try::Tiny qw( try );

get '/' => sub {
    my $c = shift;
    $c->render( template => 'index' );
};

get '/quiz/:id' => sub {
    my $c = shift;

    # Fake a singleton
    state $config = LDSQuiz::Model->new->config;

    my $model = LDSQuiz::Model->new(
        config   => $config,
        position => $c->param('position') || 0,
        quiz_id  => $c->param('id'),
    );

    my $quiz;
    try {
        $quiz = $model->quiz;
    };

    return $c->reply->not_found unless $quiz;

    $c->stash( model => $model );
    return _save_and_render_answer($c) if defined $c->param('answer');

    $c->render( template => 'quiz' );
} => 'quiz';

sub _save_and_render_answer {
    my $c    = shift;
    my $quiz = $c->stash('model')->quiz;
    $c->session->{answers}->{ $quiz->id }->[ $quiz->position ]
        = $c->param('answer');
    $c->render( template => 'answer' );
}

app->start;
