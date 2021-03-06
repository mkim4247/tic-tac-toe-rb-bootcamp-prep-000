WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user)
  user.to_i - 1
end

def player_move(board, index, char)
  board[index] = char 
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil 
    return false 
  else
    return true 
  end 
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) == false 
    return true 
  else 
    return false 
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0 
  board.each do |space| 
    if space == "X" or space == "O"
      counter += 1
    end
  end 
  return counter 
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else 
    return "O"
  end 
end 

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end 
end 

def full?(board)
  if board.any?{|i| i == " " || nil}
    return false 
  end 
  if board.all?{|space| space == "X" || "O"}
    return true 
  end 
end 

def draw?(board)
  full?(board) && !won?(board)
end 

def over?(board)
  won?(board) || draw?(board) || full?(board)
end 

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo[0]]
  end 
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end




