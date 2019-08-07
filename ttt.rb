def newBoard
    "---------"
end

def nextPlayer(board)
    plays = board.scan(/-/).count % 2
    plays == 0 ? "O" : "X"
end

def prevPlayer(board)
    nextPlayer(board) == "O" ? "X" : "O"
end

def move (input, board)
    player = nextPlayer(board)
    board[input.to_i - 1] = player
    board
end

def play(board)
    input = gets.strip
    if valid?(input, board)
        move(input, board)
    else
        puts "invalid move"
        play(board)
    end
end

def valid?(input, board)
    in_range = input.to_i.between?(1, 9)
    not_taken = board[input.to_i - 1] == "-"
    in_range && not_taken
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
        "..#.#.#.."
    ].map {|pattern| pattern.gsub("#", prevPlayer(board))}
    .any? {|pattern| Regexp.new(pattern).match(board)}
end

def draw?(board)
    !won?(board) && !board.include?("-")
end

def game(current_board)
    board = play(current_board)
    puts display(board)

    if won?(board)
        puts "#{prevPlayer(board)} wins"
        "#{prevPlayer(board)} wins"
    elsif draw?(board)
        puts "Draw"
        "Draw"
    else
        game(board)
    end
end

def display(board)
    board
        .clone
        .split(//)
        .each_slice(3)
        .to_a
        .map {|row| row.join("|")}
        .join("\n-----\n")
end