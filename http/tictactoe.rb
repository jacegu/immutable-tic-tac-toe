require 'sinatra'
require 'json'
require_relative '../lib/tictactoe/game'

use Rack::Session::Cookie, :key => 'rack.session',
                           :expire_after => 3600,
                           :secret => 'foobar'
enable :sessions

get '/' do
  new_game unless session.has_key?(:game)
  @current_player = game.next_turn_player
  @positions = game.board.positions
  haml :game
end

get '/new_game' do
  new_game
  redirect '/'
end

put '/move' do
  content_type :json
  session['game'] = game.make_move(params['position'].to_i)
  JSON.dump(
    over:        game.over?,
    winner:      game.winner,
    next_player: game.next_turn_player,
    board_state: game.board.positions
  )
end

def game
  session[:game] || new_game
end

def new_game
  session[:game] = TicTacToe::Game.new([:player1, :player2])
end
