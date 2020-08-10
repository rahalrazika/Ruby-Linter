#!/usr/bin/env ruby
require_relative '../lib/naming_test.rb'

class Linter
  include NamingTest

  def initialize(_file_path)
    @each_variable_name_error = {}
    @each_method_name_error = {}
    @each_class_name_error = {}
    @each_module_name_error = {}
  end

  def launch
    puts 'Launching DragonLint...'
    puts 'Please enter which Ruby file from bin/error/ directory you would like to scan.'
    puts 'Enter "*" to scan all .rb files'
    @file = gets.chomp
    @file_path = 'bin/error/' + @file
  end

  def read_file(file)
    puts 'Opening .rb file...'
    if file[-3, 3] != '.rb'
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
    puts test_variable_name(@file_path)
    puts test_method_name(@file_path)
    puts test_class_name(@file_path)
    puts test_module_name(@file_path)
  end

  def run
    launch
    read_file(@file_path) unless @file == '*'
  end
end

lint = Linter.new('bin/error/test.rb')
lint.run
