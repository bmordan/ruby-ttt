require_relative "../ttt"

describe "The Game" do
  it "has a board" do
    expect(newBoard).to eq("---------")
  end

  it "will auto swap player" do
    expect(nextPlayer(newBoard)).to eq("X")
  end

  it "involives making plays on the board" do
    allow(self).to receive(:gets).and_return("9")
    expect(play(newBoard)).to eq("--------X")
  end

  it "should auto change the players" do
    allow(self).to receive(:gets).and_return("1", "2")
    board1 = play(newBoard)
    board2 = play(board1)
    expect(board2).to eq("XO-------")
  end

  it "will validate user input" do
    allow(self).to receive(:gets).and_return("1", "1", "20", "-1", "9")
    board1 = play(newBoard)
    board2 = play(board1)
    expect(board2).to eq("X-------O")
    expect(nextPlayer(board2)).to eq("X")
  end

  it "check for winners" do
    expect(won?("X--------")).to be(false)
    expect(won?("XXX----OO")).to be(true)
  end

  it "draw, it happens sometimes" do
    expect(draw?("X--------")).to be(false)
    expect(draw?("XXOOOXXOX")).to be(true)
  end

  it "always ends" do
    allow(self).to receive(:gets).and_return("2", "6", "8", "5", "1", "4")
    end_state = game(newBoard)
    expect(end_state).to eq("O wins")
  end

  it "will display the board in a grid" do
    allow(self).to receive(:gets).and_return("1", "5", "9")
    board1 = play(newBoard)
    board2 = play(board1)
    board3 = play(board2)
    ui_board = display(board3)
    expect(ui_board).to eq("X|-|-\n-----\n-|O|-\n-----\n-|-|X")
  end
end
