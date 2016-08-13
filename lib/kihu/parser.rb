require "kihu/parser/version"
require 'time'

module Kihu
  module Parser
    def self.parse (text)
      kihu = []
      text.lines do |row|
        kihu << parse_row(row)
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
      '歩' => 'hu',
      '香' => 'kyou',
      '桂' => 'keima',
      '銀' => 'gin',
      '金' => 'kin',
      '王' => 'ou',
      '飛' => 'hisya',
      '角' => 'kaku',
      '龍' => 'ryuu',
      '馬' => 'uma',
      '成桂' => 'narikei',
      '成香' => 'narikyou',
      '成銀' => 'narigin',
      'と' => 'to'
    }

    # parse each row of kihu format
    # convert
    #   1 ２六歩(27)   ( 0:03/00:00:03)
    # to
    #   {:koma=>"hu", :to=>{:x=>2, :y=>6}, :from=>{:x=>2, :y=>7}, :time=>3, :naru=>false, :utsu=>false}
    def self.parse_row (row)
      return nil if is_touryou_row row

      to = "(?<to_x>[#{ZENKAKU_NUMS.keys.join}])(?<to_y>[#{KANJI_NUMS.keys.join}])"
      time = '\(\s?(?<time>[\d:]+)\/(?<total_time>[\d:]+)\)'
      from = '\((?<from_x>\d)(?<from_y>\d)\)'
      koma = "(?<koma>#{KOMAS.keys.join('|')})"
      matcher = /\d+\s#{to}#{koma}(?<naru>成?)((?<utsu>打?)|#{from})\s+#{time}/
      m = matcher.match row

      raise 'illegal kihu format' unless m
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

    def self.is_touryou_row (row)
      !/\d+\s投了/.match(row).nil?
    end
  end
end