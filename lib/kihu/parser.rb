require "kihu/parser/version"
require 'time'

module Kihu
  module Parser
    def self.parse (text)
      kihu = []
      text.lines do |row|
        # kihu << parse_row row
      end
      kihu
    end

    ZENKAKU_NUMS = {
      '１' => 1,
      '２' => 2,
      '３' => 3,
      '４' => 4,
      '５' => 5,
      '６' => 6,
      '７' => 7,
      '８' => 8,
      '９' => 9
    }

    KANJI_NUMS = {
      '一' => 1,
      '二' => 2,
      '三' => 3,
      '四' => 4,
      '五' => 5,
      '六' => 6,
      '七' => 7,
      '八' => 8,
      '九' => 9
    }

    KOMAS = {
      '歩' => 'hu'
    }

    # parse each row of kihu format
    # convert
    # 1 ２六歩(27)   ( 0:03/00:00:03)
    # to
    # {:koma=>"hu", :to=>{:x=>2, :y=>6}, :from=>{:x=>"2", :y=>"7"}, :time=>3}
    def self.parse_row (row)
      to = "(?<to_x>[#{ZENKAKU_NUMS.keys.join}])(?<to_y>[#{KANJI_NUMS.keys.join}])"
      time = '\(\s?(?<time>[\d:]+)\/(?<total_time>[\d:]+)\)'
      from = '\((?<from_x>\d)(?<from_y>\d)\)'
      matcher = /\d+\s#{to}(?<koma>[#{KOMAS.keys.join}])(?<naru>成?)((?<utsu>打?)|#{from})\s+#{time}/
      m = matcher.match row

      result = 
        {
          koma: KOMAS[m[:koma]],
          to: {
            x: ZENKAKU_NUMS[m[:to_x]].to_i,
            y: KANJI_NUMS[m[:to_y]].to_i
          },
          time: Time.parse(m[:total_time]).sec,
          naru: m[:naru].size > 0
        }

      if m[:utsu].nil?
        result[:from] = {
          x: m[:from_x].to_i,
          y: m[:from_y].to_i
        }
        result[:utsu] = false
      else
        result[:from] = nil
        result[:utsu] = true
      end

      result
    end
  end
end