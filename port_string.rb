#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class PortString < String

  FormatError = Class.new(StandardError)
  LengthError = Class.new(StandardError)

  MAX_LENGTH = 3
  BASIC_RANGE = ('a'..'z').to_a + ['_']     #27
  EXT_RANGE = BASIC_RANGE + ('0'..'9').to_a + %w[^ - @ % +] #42
  INDICES = EXT_RANGE.each_with_index.map {|letter,index| [letter, index]}.to_h

  REGEXP = /^[#{Regexp.escape(BASIC_RANGE.join)}]{1}[#{Regexp.escape(EXT_RANGE.join)}]{0,2}$/
  PADDER = '_'

  PORT_START = 1024

  def initialize(string)
    super
    raise LengthError unless length <= MAX_LENGTH
    @chars = split('')
    pad
    raise FormatError unless @chars.join.match(REGEXP)
    @i = PORT_START + offset
  end
  def to_i
    @i
  end
  def offset
    ret = INDICES[@chars[0]] + 
      BASIC_RANGE.size * INDICES[@chars[1]] +
      BASIC_RANGE.size * EXT_RANGE.size * INDICES[@chars[2]]
    return ret
  end
  def pad
    while @chars.size < 3
      @chars.push(PADDER)
    end
  end
end

if __FILE__ == $0
  printer = lambda do |arg|
    begin
      puts PortString.new(arg).to_i
    rescue PortString::FormatError, PortString::LengthError => e
      warn e
      warn "The PortString must match: #{PortString::REGEXP}"
    end
  end
  args = ARGV.size != 0 ? ARGV : STDIN.lazy.map(&:chomp)
  args.each(&printer)
end
