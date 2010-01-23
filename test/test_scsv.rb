require File.dirname(__FILE__) + '/test_helper.rb'

class TestAbc < Test::Unit::TestCase

  def setup
  end
  
  def test_truth
    assert true
  end
  
  def test_parse_csv_with_block
    SCSV.parse("test/_data/csv_has_header.txt") do |row|
      assert_instance_of Hash, row
    end
    SCSV.parse("test/_data/csv_has_no_header.txt", {:header => false}) do |row|
      assert_instance_of Array, row
    end
    SCSV.parse("test/_data/csv_has_no_header.txt", {:header => ["h1", "h2", "h3"]}) do |row|
      assert_instance_of Hash, row
    end
  end
end
