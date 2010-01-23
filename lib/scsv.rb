$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

#
# for COMMA separated file
#
class SCSV  
  VERSION = '0.1.0'
  
  DEFAULT_OPTIONS = {
    :col_sep  => ",",
    :row_sep  => "\n",
    :header   => true,
  }
  
  def self.parse(filename, options = {}, &block)
    p options = DEFAULT_OPTIONS.merge(options)
    if block_given?
      parse_with_block(filename, options, &block)
    else
      rows = []
      parse_with_block(filename, options) do |row|
        rows << row
      end
      return rows
    end
  end
  
  def self.parse_with_block(filename, options, &block)
    Kernel.open(filename, "r") do |f|
      header = nil
      if options[:header] && options[:header].is_a?(Array)
        # using passed Array
        header = options[:header]
      elsif options[:header]
        # using file's first row
        header = f.gets.gsub(/\n/, "").split(options[:col_sep])
      end
      # read lines
      f.each do |line|
        tokens = line.gsub(/\n/, "").split(options[:col_sep])
        row = tokens
        if header
          row = {}
          tokens.each_with_index do |i, idx|
            row[header[idx]] = i
          end
        end
        yield(row)
      end
    end
  end
end

#
# for TAB separated file
#
class STSV < SCSV
  # overwrite col_sep
  DEFAULT_OPTIONS = DEFAULT_OPTIONS.dup
  DEFAULT_OPTIONS[:col_sep] = "\t"
  # overwrite methods
  def self.parse(filename, options = DEFAULT_OPTIONS, &block)
    super
  end
end
