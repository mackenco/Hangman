class ComputerPlayer
  attr_accessor :difficulty

  def initialize(dictionary_source)
    @guessed_letters = []
    @available_letters = ('a'..'z').to_a
    @dict = File.readlines(dictionary_source).map(&:chomp)
  end

  def update_dict(secret_word)
    # step 0: eliminate words of wrong length
    @dict.select! {|word| word.length == secret_word.length }

    # step 1: form regex?
    regex_string = get_regex(secret_word)
    regex = Regexp.new(regex_string)
    @dict.select! {|word| word =~ regex}
  end

  def smart_letter
    all_chars = @dict.map{|word| word.split("")}.flatten
    remaining_chars = all_chars.delete_if {|c| @guessed_letters.include?(c)}
    mode(remaining_chars)
  end

  def medium_letter
    arr = @dict.sample.split("")
    loop do
      char = arr.sample
      next if @guessed_letters.include?(char)
      return char
    end
  end

  def mode(arr)
    freq = arr.inject(Hash.new(0)) { |hash, value| hash[value] += 1; hash}
    arr.sort_by { |value| freq[value]}.last
  end

  def get_regex(secret_word)
    str = ""
    secret_word_arr = secret_word.split("")
    available_letters_string = "[#{@available_letters.join("")}]"
    secret_word_arr.each do |char|
      char == "_" ? str << available_letters_string : str << char
    end
    str
  end

  def get_dumb_letter
    letter = ""
    loop do
      letter = ('a'..'z').to_a.sample
      break unless @guessed_letters.include?(letter)
    end
    letter
  end


  def get_input(secret_word)
    update_dict(secret_word)
    case @difficulty
    when 1
      letter = get_dumb_letter
    when 2
      letter = medium_letter
    when 3
      letter = smart_letter
    end
      @guessed_letters << letter
      @available_letters.delete(letter)
      puts letter
      letter
  end

  def choose_word
    @dict.sample
  end

  def update_secret_word(word, guessed_letters, secret_word)
    secret = ""
    word.length.times do |time|
      guessed_letters.include?(word[time]) ? secret << word[time] : secret << "_"
    end
    puts "Secret word: #{secret}"
    secret
  end
end