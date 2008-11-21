require File.dirname(__FILE__) + '/test_helper'

require "XmlReader.bundle"
OSX::ns_import :XmlReader

class TestXmlReader < Test::Unit::TestCase
  def test_xml_reader_class_exists
    OSX::XmlReader
  end
end