#!/usr/bin/env ruby

class Linter
  def read_file(file)
    puts 'Launching DragonLint...'
    puts 'Opening file...'
    begin
      puts "Total lines of code to be checked within '#{file}': #{File.open(file).readlines.size}"
      puts 'Searching for linting errors...'
    rescue StandardError
      puts "Unable to open file '#{file}' please ensure specified path given is correct."
      exit
    end
  end

  def run
    read_file('bin/error/test.rb')
  end
end

lint = Linter.new
lint.run
