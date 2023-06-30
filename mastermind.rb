class Game
  attr_accessor :computer_array, :player_array, :same_index
  RANGE = ['1','2','3','4','5','6']
  @@TURNS = 0

  def player_input
    puts "Type a number from 1 to 6, in a row of 4"
    input = gets.chomp   
    @player_array = input.split(//)
    p player_array
  end

  def computer_selection
    @computer_array = 4.times.map {RANGE.sample}
    # p computer_array
  end

  def play_game
      computer_selection
    until @@TURNS == 10 || @same_index == 4
      player_input
      check_position
      @@TURNS += 1
    end
    winner_checker
  end

  def check_position
    common_items = @player_array.intersection(@computer_array)
    diff = @player_array.map.with_index { |x,i| x == @computer_array[i] }
    @same_index = diff.count(true)
    p "There are #{common_items.length} items in common, of which #{same_index} are in the correct place"
  end

  def winner_checker
    if @same_index == 4 && @@TURNS < 10
      p "You win! All numbers are in correct place!"
    elsif @same_index != 4 && @@TURNS == 10
      p "End of game! You did not break the code!"
    end
  end
end

game = Game.new
game.play_game


