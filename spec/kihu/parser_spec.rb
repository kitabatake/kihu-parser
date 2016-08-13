require 'spec_helper'

describe Kihu::Parser do
  it 'has a version number' do
    expect(Kihu::Parser::VERSION).not_to be nil
  end

  describe 'parse_row' do
    it 'is common case' do 
      row = Kihu::Parser.parse_row('1 ２六歩(27)   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'hu'
      expect(row[:from]).to eq ({x: 2, y: 7})
      expect(row[:to]).to eq ({x: 2, y: 6})
      expect(row[:time]).to eq 3
      expect(row[:naru]).to eq false
    end

    it 'is naru case' do 
      row = Kihu::Parser.parse_row('1 ２三歩成(24)   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'hu'
      expect(row[:from]).to eq ({x: 2, y: 4})
      expect(row[:to]).to eq ({x: 2, y: 3})
      expect(row[:time]).to eq 3
      expect(row[:naru]).to eq true
    end
  end
end
