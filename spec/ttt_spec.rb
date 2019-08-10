require_relative "../ttt"

describe "The Game" do
  it "has a zero index board" do
    expect(newBoard).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "will auto swap players from X to O" do
    expect(nextPlayer(newBoard)).to eq("X")
  end

  it "can make moves" do
    expect(move(8, newBoard)).to eq([0, 1, 2, 3, 4, 5, 6, 7, "X"])
  end

  it "it will alternate counters" do
    board1 = move(0, newBoard)
    board2 = move(1, board1)
    expect(board1).to eq(["X", 1, 2, 3, 4, 5, 6, 7, 8])
    expect(board2).to eq(["X", "O", 2, 3, 4, 5, 6, 7, 8])
  end

  it "only allows valid moves" do
    expect(valid?(20, newBoard)).to be(false)
    expect(valid?(-2, newBoard)).to be(false)
    expect(valid?(0, newBoard)).to be(true)
    board = move(0, newBoard)
    expect(valid?(0, board)).to be(false)
  end

  it "can turn the board to a string" do
    board = ["X", "O", 2, 3, 4, "X", 6, 7, 8]
    expect(board_to_string(board)).to eq("XO---X---")
  end

  it "will check for a win" do
    hasWon = ["X", "X", "X", 3, 4, 5, 6, "O", "O"]
    expect(won?(newBoard)).to be(false)
    expect(won?(hasWon)).to be(true)
  end

  it "will check for draws" do
    expect(draw?(["X", "X", "X", 3, 4, 5, 6, "O", "O"])).to be(false)
    expect(draw?(["X", "X", "O", "O", "O", "X", "X", "O", "X"])).to be(true)
  end

  it "will end in a terminal state" do
    allow(self).to receive(:gets).and_return("2", "6", "8", "5", "1", "4")
    end_state = cli_game(newBoard)
    expect(end_state).to eq("O wins")
  end

  it "will display the board nicely" do
    board = ["X", "X", "X", 3, 4, 5, 6, "O", "O"]
    displayed_board = "X|X|X\n-----\n-|-|-\n-----\n-|O|O"
    expect(display(board)).to eq(displayed_board)
  end
end
