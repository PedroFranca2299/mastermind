class Game
  attr_accessor :computer_array, :player_array, :same_index, :choice
  RANGE = ['1','2','3','4','5','6']
  @@TURNS = 0

  def master_or_decoder
    puts "Type 1 if you want to be the Code Creator, or 2 if you want to be the Code Breaker"
    @choice = gets.chomp
    while choice.ord < 49 || choice.ord > 50 || choice == nil
      puts "Please type a valid number and/or the correct amount of characters"
      @choice = gets.chomp
    end
  end
  
  def player_input
    puts "Type a number from 1 to 6, in a row of 4"
    input = gets.chomp   
    @player_array = input.split(//)
    p player_array
    validation = player_array.any? { |element| element.ord < 49 || element.ord > 54 }
    until !validation && player_array.length == 4
      puts "Please type a valid number and/or the correct amount of characters"
      input = gets.chomp   
      @player_array = input.split(//)
      p player_array
      validation = player_array.any? { |element| element.ord < 49 || element.ord > 54 }
    end
  end

  def computer_selection
    @computer_array = 4.times.map {RANGE.sample}
    # p computer_array
  end

  def play_game
    master_or_decoder
    if @choice == "1"
      player_input
      until @@TURNS == 10 || @same_index == 4
        computer_selection
        check_position_computer
        @@TURNS += 1
      end
      computer_selection
    elsif @choice == "2"
      computer_selection
      until @@TURNS == 10 || @same_index == 4
        player_input
        check_position_player
        @@TURNS += 1
      end
    end
    winner_checker
  end

  def check_position_player
    common_items = @player_array.intersection(@computer_array)
    diff = @player_array.map.with_index { |x,i| x == @computer_array[i] }
    @same_index = diff.count(true)
    p "There are #{common_items.length} items in common, of which #{same_index} are in the correct place"
  end

  def check_position_computer
    common_items = @computer_array.intersection(@player_array)
    diff = @computer_array.map.with_index { |x,i| x == @player_array[i] }
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


