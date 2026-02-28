# frozen_string_literal: true

# Game board, has two players and can render a board and check
# if either of players won.
class Board
  WIN_CONDITIONS = [
    [
      [0, 0],
      [0, 1],
      [0, 2]
    ],
    [
      [1, 0],
      [1, 1],
      [1, 2]
    ],
    [
      [2, 0],
      [2, 1],
      [2, 2]
    ],
    [
      [0, 0],
      [1, 0],
      [2, 0]
    ],
    [
      [0, 1],
      [1, 1],
      [2, 1]
    ],
    [
      [0, 2],
      [1, 2],
      [2, 2]
    ],
    [
      [0, 0],
      [1, 1],
      [2, 2]
    ],
    [
      [0, 2],
      [1, 1],
      [2, 0]
    ]
  ]

  MOVE_MAPPINGS = [
    [0, 0],
    [0, 1],
    [0, 2],
    [1, 0],
    [1, 1],
    [1, 2],
    [2, 0],
    [2, 1],
    [2, 2]
  ]

  def initialize(player_one, player_two) # rubocop:disable Metrics/MethodLength
    player_one.piece = {
      sym: 'x',
      number: 1
    }
    player_two.piece = {
      sym: 'o',
      number: 2
    }
    @players = [player_one, player_two]

    @game_state = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]
  end

  def play_game
    loop do
      render_board
      break if play_round
    end
  end

  private

  attr_reader :players
  attr_accessor :game_state

  def render_board
    game_state.each do |row|
      print '|'
      row.each do |cell|
        case cell
        when 0
          print ' '
        when 1
          print 'x'
        when 2
          print 'o'
        end
        print '|'
      end
      puts
    end
  end

  def play_round
    players.each do |player|
      move = player.prompt_a_move
      update_board(player.piece[:number], move)
      render_board

      if win?(player.piece[:number])
        game_won(player)
        return true
      end
    end
    false
  end

  def update_board(player_number, move)
    mapped_move = MOVE_MAPPINGS[move - 1]
    game_state[mapped_move[0]][mapped_move[1]] = player_number
  end

  def win?(player_number)
    WIN_CONDITIONS.each do |conditions|
      met_conditions = 0
      conditions.each do |c|
        met_conditions += 1 if game_state[c[0]][c[1]] == player_number
      end
      return true if met_conditions == 3
    end
    false
  end

  def game_won(player)
    puts "Player #{player.name} won."
  end
end
