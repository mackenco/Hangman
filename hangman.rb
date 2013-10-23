load "ComputerPlayer.rb"
load "HumanPlayer.rb"
load "Draw_Hangman.rb"

class Hangman
  TRIES = 8
  def initialize(wordsmith, guesser)
    @guessed_letters = []
    @wordsmith = wordsmith
    @guesser = guesser
  end

  def victory_check(word, secret_word)
    secret_word.split("").each do |letter|
      return false if letter == '_'
    end
    puts "The guesser wins!"
    true
  end

  def play(drawer)
    word = @wordsmith.choose_word
    i = 0
    secret = ""
    secret_word = @wordsmith.update_secret_word(word, @guessed_letters, secret)

    while i < TRIES
      drawer.draw(i)
      previous_secret_word = secret_word.dup
      @guessed_letters << @guesser.get_input(secret_word)

      secret_word = @wordsmith.update_secret_word(word, @guessed_letters, secret_word)
      i += 1 if secret_word == previous_secret_word

      return if victory_check(word, secret_word)

      puts "You have #{TRIES - i} tries remaining!"
    end
    drawer.draw(i)
    puts "The wordsmith wins. The correct word was #{word}"
  end
end

def player_choice
    puts "Are you guessing(1) or choosing a word(2)?"
    choice = gets.chomp.to_i
end

def difficulty_set
  puts "Would you like an easy(1), medium(2), or hard(3) guesser?"
  choice = gets.chomp.to_i
end

def number_humans
  puts "How many humans will be playing? (0, 1, or 2)"
  gets.chomp.to_i
end

if __FILE__ == $PROGRAM_NAME
  case number_humans
  when 0
    computer_wordsmith = ComputerPlayer.new("dictionary.txt")
    computer_guesser = ComputerPlayer.new("dictionary.txt")
    computer_guesser.difficulty = difficulty_set
    hm = Hangman.new(computer_wordsmith, computer_guesser)
  when 1
    human = HumanPlayer.new
    computer = ComputerPlayer.new("dictionary.txt")
    case player_choice
    when 1
      hm = Hangman.new(computer, human)
    when 2
      hm = Hangman.new(human, computer)
      computer.difficulty = difficulty_set
    end

  when 2
    human_wordsmith = HumanPlayer.new
    human_guesser = HumanPlayer.new
    hm = Hangman.new(human_wordsmith, human_guesser)
  end
  drawer = Draw_Hangman.new
  hm.play(drawer)
end