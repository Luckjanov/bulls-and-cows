class BullsAndCows
  def initialize
    new_game
  end

  # Initialize class
  def new_game
    @guess_num = []
    @result
    r = Random.new
    until @guess_num[3]
      digit = r.rand(0..9)
      @guess_num << digit unless @guess_num.include? digit
    end    
  end

  # Start the game
  # Return :win, :quit or :resign
  def play
    puts "Let's play 'Bulls and Cows'! (if you are stuck enter 'resign' or 'quit')"
    loop do 
      prompt()
      @user_try = gets.chomp()
      if @user_try == 'resign'
        @result = :resign
        puts "Number was #{@guess_num.join}"
        break
      end
      if @user_try == 'quit'
        @result = :quit
        puts "Number was #{@guess_num.join}"
        break
      end
      @result = test() if correct?
    end
    return @result
  end

private

  # User inputed correct number?
  def correct?
    if !( /^[0-9]{4}$/ =~ @user_try)  || @user_try.split("").uniq!
      puts 'Please, enter different 4 numbers'
      return false
    end
    return true
  end

  # Check win user or not
  # If not print amount of cows and bulls
  def test
    b = bulls()
    c = cows()- b
    if b == 4
      puts 'Congrats!'
      return :win
    end
    puts "\t#{b} - bulls\n\t#{c} - cows"
  end

  # Calculate bulls
  def bulls
    @arr = @user_try.split("")
    @arr.map! {|e| e.to_i}
    b = 0
    @arr.each_with_index do |e, ind|
      b+=1 if e == @guess_num[ind]
    end
    return b
  end

  # Calculate cows
  # It can be called after bulls() only
  def cows
    (@arr & @guess_num).size
  end

  def prompt
    print '> '
  end
end

game = BullsAndCows.new
begin
  result = game.play
  game.new_game
end until result == :quit