require 'spec_helper'

KIHU_SAMPLE_DIR = File.dirname(__FILE__) + '/../kihu_sample/'

def get_sample_txt (name)
  kihu_text = ''
  File.open(KIHU_SAMPLE_DIR + name) do |file|
    kihu_text = file.read
  end
  kihu_text
end

describe KihuParser do
  it 'has a version number' do
    expect(KihuParser::VERSION).not_to be nil
  end

  let(:kp) { KihuParser.new }

  describe 'whole parse' do
    it 'is common case' do
      sample = get_sample_txt 'sample1.txt'
      result = kp.parse(sample)
      expect(result[:date].to_s).to eq '2016-08-02 20:04:56 +0900'
      expect(result[:rule]).to eq 'R対局(15分)'
      expect(result[:handicap]).to eq '平手'
      expect(result[:sente]).to eq 'sente'
      expect(result[:gote]).to eq 'gote'
      expect(result[:moves].size).to eq 140
    end
  end

  describe 'parse_moves' do
    it 'is common case' do
      moves = [
        '1 ２六歩(27)   ( 0:03/00:00:03)',
        '2 ３四歩(33)   ( 0:02/00:00:02)'
      ]
      result = kp.parse_moves moves
      expect(result.size).to eq 2
    end
  end

  describe 'parse_moves_row' do
    it 'is common case' do 
      row = kp.parse_moves_row('1 ２六歩(27)   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'hu'
      expect(row[:from]).to eq ({x: 2, y: 7})
      expect(row[:to]).to eq ({x: 2, y: 6})
      expect(row[:time]).to eq 3
      expect(row[:naru]).to eq false
      expect(row[:utsu]).to eq false
    end

    it 'is multi charactors koma' do
      row = kp.parse_moves_row('1 ２六成銀(27)   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'narigin'
    end

    it 'is naru case' do 
      row = kp.parse_moves_row('1 ２三歩成(24)   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'hu'
      expect(row[:from]).to eq ({x: 2, y: 4})
      expect(row[:to]).to eq ({x: 2, y: 3})
      expect(row[:time]).to eq 3
      expect(row[:naru]).to eq true
      expect(row[:utsu]).to eq false
    end

    it 'is utsu case' do
      row = kp.parse_moves_row('21 ２三歩打   ( 0:03/00:00:03)')
      expect(row[:koma]). to eq 'hu'
      expect(row[:from]).to eq nil
      expect(row[:to]).to eq ({x: 2, y: 3})
      expect(row[:time]).to eq 3
      expect(row[:naru]).to eq false
      expect(row[:utsu]).to eq true
    end

    it 'is touryou case' do
      row = kp.parse_moves_row('21 投了')
      expect(row).to eq nil
    end

    it 'is illegal format error case' do
      expect{ kp.parse_moves_row('21 aaaaaaaaa') }.to raise_error(RuntimeError)
    end
  end
end
