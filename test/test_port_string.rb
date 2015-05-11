# -*- coding: utf-8 -*-
require 'minitest/autorun'
require_relative '../port_string'

describe PortString do
  first = 'aaa'
  it "#{first} should match to the start of the range" do
    assert_equal 1024, PortString.new(first).to_i
  end
  last = "_++"
  it "#{last} should match to the end of the range" do
    assert_equal(1024 + 26 + 41*27 + 27*42*41, PortString.new(last).to_i)
  end

  it "should throw LengthError on too long input" do
    assert_raises(PortString::LengthError) {
      PortString.new("foobar")
    }
    assert_raises(PortString::LengthError) {
      PortString.new("foob")
    }
  end

  it "should throw FormatError on ill-formatted input" do
    [""] + %w[-fo - 1 0 Aoo HEY].each do |input|
      assert_raises(PortString::FormatError) {
        PortString.new(input)
      }
    end
  end

end

