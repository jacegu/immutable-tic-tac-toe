require 'board'

describe TicTacToe::Board do
  it 'knows what positions are valid' do
    expect(subject.valid?(-1)).to eq(false)
    expect(subject.valid?(0)).to eq(true)
    expect(subject.valid?(5)).to eq(true)
    expect(subject.valid?(8)).to eq(true)
    expect(subject.valid?(9)).to eq(false)
  end
end
