def newBoard
  (0..8).to_a
end

def nextPlayer(board)
  board.filter { |i| i.is_a? Integer }.count.odd? ? "X" : "O"
end

def currentPlayer(board)
  nextPlayer(board) == "X" ? "O" : "X"
end

def move(index, board)
  player = nextPlayer(board)
  if valid?(index, board)
    nextBoard = board.clone
    nextBoard[index] = player
    nextBoard
  else
    puts "invalid input"
    board
  end
end

def valid?(index, board)
  in_range = index.between?(0, 8)
  not_taken = board[index].is_a?(Integer)
  in_range && not_taken
end

def board_to_string(board)
  board.map { |i| i.is_a?(Integer) ? "-" : i }.join("")
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
  ].map { |pattern| pattern.gsub("#", currentPlayer(board)) }
    .any? { |pattern| Regexp.new(pattern).match(board_to_string(board)) }
end

def draw?(board)
  board.filter { |i| i.is_a? Integer }.empty?
end

def game(board)
  input = gets.chomp.strip
  index = input.to_i - 1

  nextBoard = move(index, board)
  puts display(nextBoard)
  if won?(nextBoard)
    puts "#{currentPlayer(nextBoard)} wins"
    "#{currentPlayer(nextBoard)} wins"
  elsif draw?(nextBoard)
    puts "draw"
    "draw"
  else
    game(nextBoard)
  end
end

def display(board)
  board_to_string(board)
    .chars
    .each_slice(3)
    .to_a
    .map { |row| row.join("|") }
    .join("\n-----\n")
end
