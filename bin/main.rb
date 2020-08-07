#!/usr/bin/env ruby

class Linter
  def read_file(file)
    puts 'Launching DragonLint...'
    puts 'Opening .rb file...'
    if file[-2, 2] != 'rb'
      puts "Ruby file not found. The specified path '#{file}' does not end with .rb"
      exit
    else
      begin
        puts "Total lines of code to be checked within '#{file}': #{File.open(file).readlines.size}"
        puts 'Searching for linting errors...'
      rescue StandardError
        puts "Unable to open file '#{file}' please ensure specified path given is correct."
        exit
      end
    end
  end

  def run
    read_file('bin/error/test.rb')
  end
end

lint = Linter.new
lint.run
