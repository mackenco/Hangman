class HumanPlayer

  def initialize
    @guessed_letters = []
  end

  def choose_word
    puts "Enter word length"
    length = gets.chomp.to_i
    word = ""
    length.times { word << "_"}
    word
  end

  def update_secret_word(word, guessed_letters, secret_word)
    return word if secret_word.length == 0
    puts "Where are guessed letters?"
    index_arr = gets.chomp.split(',')
    index_arr.each{|place| secret_word[place.to_i - 1] = guessed_letters[-1]}
    puts "Secret word: #{secret_word}"
    secret_word
  end

  def get_input(secret_word)
    puts "Letters guessed: #{@guessed_letters.join(", ")}"
    loop do
      letter = gets.downcase.chomp[0]
      if ('a'..'z').include?(letter)
        @guessed_letters << letter
        return letter
      end
    end
  end
end