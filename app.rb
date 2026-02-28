# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

board = Board.new(Player.new('John'), Player.new('Alysa'))
board.play_game
