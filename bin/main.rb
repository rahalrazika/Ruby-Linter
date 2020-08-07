#!/usr/bin/env ruby

class Linter
  def read_file(file)
    puts 'Opening file...'
    puts "Total lines of code within file to be assesed: #{File.open(file).readlines.size}"
  end

  def run
    read_file('bin/error/test.rb')
  end
end

lint = Linter.new
lint.run
