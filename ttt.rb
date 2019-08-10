def newBoard
  (0..8).to_a
end

def nextPlayer(board)
  plays = board.filter { |i| i.is_a?(Integer) }.count % 2
  plays == 0 ? "O" : "X"
end

def prevPlayer(board)
  nextPlayer(board) == "O" ? "X" : "O"
end

def valid?(index, board)
  in_range = index.between?(0, 8)
  not_taken = board[index].is_a? Integer
  in_range && not_taken
end

def move(index, board)
  counter = nextPlayer(board)
  nextBoard = board.clone
  nextBoard[index] = counter
  nextBoard
end

def play(board)
  input = gets.strip
  if valid?(input, board)
    move(input, board)
  else
    puts "invalid move, try again"
    play(board)
  end
end

def board_to_string(board)
  board
    .map { |i| i.is_a?(Integer) ? "-" : i }
    .join("")
end

def won?(board)
  wins = [
    "###......",
    "...###...",
    "......###",
    "#..#..#..",
    ".#..#..#.",
    "..#..#..#",
    "#...#...#",
    "..#.#.#..",
  ].map { |pattern| pattern.gsub("#", prevPlayer(board)) }
   .any? { |pattern| Regexp.new(pattern).match(board_to_string(board)) }
end

def draw?(board)
  !board.any? { |i| i.is_a?(Integer) }
end

def cli_game(prev_board)
  input = gets.chomp.strip
  index = input.to_i - 1
  board = move(index, prev_board)
  puts display board
  if won?(board)
    "#{prevPlayer(board)} wins"
  elsif draw?(board)
    "draw"
  else
    cli_game(board)
  end
end

def display(board)
  board_to_string(board)
    .chars
    .each_slice(3).to_a
    .map { |row| row.join("|") }.join "\n-----\n"
end
