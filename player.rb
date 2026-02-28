# frozen_string_literal: true

# Player can have a name and can make a move
class Player
  attr_reader :name
  attr_accessor :piece

  def initialize(name)
    @name = name
  end

  def prompt_a_move
    puts "Player #{name}, make a move with #{piece[:sym]}."
    puts '|1|2|3|'
    puts '|4|5|6|'
    puts '|7|8|9|'
    gets.chomp.to_i
  end
end
