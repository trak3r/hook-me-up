require File.dirname(__FILE__) + '/test_helper'

require "Hooker.bundle"
OSX::ns_import :Hooker

class TestHooker < Test::Unit::TestCase
  def test_hooker_class_exists
    OSX::Hooker
  end
end