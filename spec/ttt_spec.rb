require_relative "../ttt.rb"

describe "The Game of Tic Tac Toe" do
  it "has a board" do
    expect(newBoard).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "can figure the player out" do
    expect(nextPlayer(newBoard)).to eq("X")
  end

  it "current player" do
    expect(currentPlayer(newBoard)).to eq("O")
  end

  it "you play by making moves on the board" do
    board = move(8, newBoard)
    expect(board).to eq([0, 1, 2, 3, 4, 5, 6, 7, "X"])
    board2 = move(0, board)
    expect(board2).to eq(["O", 1, 2, 3, 4, 5, 6, 7, "X"])
  end

  it "you can only move if its valid" do
    expect(valid?(20, newBoard)).to be(false)
    expect(valid?(-3, newBoard)).to be(false)
    expect(valid?(0, newBoard)).to be(true)
    board = move(0, newBoard)
    expect(valid?(0, board)).to be(false)
  end

  it "should sometimes have a winner" do
    expect(won?(newBoard)).to be(false)
    expect(won?(["X", "X", "X", 3, 4, 5, 6, "O", "O"])).to be(true)
  end

  it "can turn the board to a string" do
    expect(board_to_string(["X", "O", 2, 3, 4, 5, 6, 7, "X"])).to eq("XO------X")
  end

  it "sometimes ends in a draw" do
    expect(draw?(newBoard)).to be(false)
    expect(draw?(["X", "X", "O", "O", "O", "X", "X", "X", "O"]))
  end

  it "should end with X winning" do
    allow(self).to receive(:gets).and_return("1 ", " 9", "2", "8", "3")
    final = game(newBoard)
    expect(final).to eq("X wins")
  end

  it "should end with O winning" do
    allow(self).to receive(:gets).and_return("9", "1", "8", "2", "5", "3")
    final = game(newBoard)
    expect(final).to eq("O wins")
  end

  it "could end with a draw" do
    allow(self).to receive(:gets).and_return("1", "3", "2", "4", "6", "5", "7", "9", "8")
    final = game(newBoard)
    expect(final).to eq("draw")
  end

  it "should be seen printed in the command line" do
    board = ["X", "O", "X", 3, 4, 5, 6, 7, "O"]
    expect(display(board)).to eq("X|O|X\n-----\n-|-|-\n-----\n-|-|O")
  end
end
