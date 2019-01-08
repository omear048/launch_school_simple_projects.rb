require 'pry' # to exit exit-program

def prompt(message)
  puts "#{message}"
end

INITIAL_MARKER = " "
PLAYER_CHOICE = 'X'
COMPUTER_CHOICE = 'O'

def display_board(brd) #Calling this prompts the board to display
    # system 'clear'
    puts""
    puts"     |     |     "
    puts"  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
    puts"     |     |     "
    puts"-----+-----+-----"
    puts"     |     |     "
    puts"  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
    puts"     |     |     "
    puts"-----+-----+-----"
    puts"     |     |     "
    puts"  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
    puts"     |     |     "
    puts""
end

def initialize_board #Creating the original hash of numbers
  new_board = {}
  (1..9).each {|num| new_board[num] = INITIAL_MARKER}
  new_board
end

def empty_squares(brd) #Method to call the hash of unused squares 
  brd.keys.select {|num| brd[num] == INITIAL_MARKER}
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else 
    arr[-1] = "#{word} #{arr[-1]}"
    arr.join(delimiter)
  end
end


def player_places_piece!(brd) #Method called to place a player's piece on the board
  square = ''
  loop do
    prompt "Choose a postion to place a piece: #{joinor(empty_squares(brd), ', ')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
    brd[square] = PLAYER_CHOICE
end

def computer_places_piece!(brd)
  computer_square = ''
  loop do
    computer_square = empty_squares(brd).sample
    break
  end
    brd[computer_square] = COMPUTER_CHOICE
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]+ #winning rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]]+ #winning columns
                  [[1, 5, 9], [3, 5, 7]] #winning diagonals


  winning_lines.each do |line|
    if    brd[line[0]] == PLAYER_CHOICE &&
          brd[line[1]] == PLAYER_CHOICE &&
          brd[line[2]] == PLAYER_CHOICE
          return 'Player'
    elsif brd[line[0]] == PLAYER_CHOICE &&
          brd[line[1]] == PLAYER_CHOICE &&
          brd[line[2]] == PLAYER_CHOICE
          return 'Computer'
    end
  end
  nil
end


loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a God Damn tie!"
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic-Tac-Toe! Goodbye."




