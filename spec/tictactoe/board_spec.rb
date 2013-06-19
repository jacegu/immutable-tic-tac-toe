require 'board'

describe TicTacToe::Board do
  it 'knows what positions are valid' do
    expect(subject.valid?(-1)).to be_false
    expect(subject.valid?(0)).to be_true
    expect(subject.valid?(5)).to be_true
    expect(subject.valid?(8)).to be_true
    expect(subject.valid?(9)).to be_false
  end
end
