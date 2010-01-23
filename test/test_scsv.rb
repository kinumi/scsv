require File.dirname(__FILE__) + '/test_helper.rb'

class TestAbc < Test::Unit::TestCase

  def setup
  end
  
  def test_parse_csv_with_block
    SCSV.parse("test/_data/csv_has_header.txt") do |row|
      assert_instance_of Hash, row
      p row
    end

    SCSV.parse("test/_data/csv_has_no_header.txt", {:header => false}) do |row|
      assert_instance_of Array, row
      p row
    end

    SCSV.parse("test/_data/csv_has_no_header.txt", {:header => ["h1", "h2", "h3"]}) do |row|
      assert_instance_of Hash, row
      p row
    end

    SCSV.parse("test/_data/csv_japanese_utf8.txt") do |row|
      assert_instance_of Hash, row
      p row
    end

    SCSV.parse("test/_data/tsv.txt", {:col_sep => "\t"}) do |row|
      assert_instance_of Hash, row
      p row
    end
    STSV.parse("test/_data/tsv.txt") do |row|
      assert_instance_of Hash, row
      p row
    end
  end
  
  def test_parse_csv_with_no_block
    csv = SCSV.parse("test/_data/csv_has_header.txt")
    assert_instance_of Array, csv
    p csv

    csv = SCSV.parse("test/_data/csv_has_no_header.txt", {:header => false})
    assert_instance_of Array, csv
    p csv

    csv = SCSV.parse("test/_data/csv_has_no_header.txt", {:header => ["h1", "h2", "h3"]})
    assert_instance_of Array, csv
    p csv

    csv = SCSV.parse("test/_data/csv_japanese_utf8.txt")
    assert_instance_of Array, csv
    p csv

    csv = SCSV.parse("test/_data/tsv.txt", {:col_sep => "\t"})
    assert_instance_of Array, csv
    p csv
    csv = STSV.parse("test/_data/tsv.txt")
    assert_instance_of Array, csv
    p csv
  end
end
