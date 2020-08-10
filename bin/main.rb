#!/usr/bin/env ruby
require_relative '../lib/naming_test.rb'
require_relative '../lib/string_colors.rb'

class Linter
  include NamingTest

  def initialize()
    @each_variable_name_error = {}
    @each_method_name_error = {}
    @each_class_name_error = {}
    @each_module_name_error = {}
  end

  def launch
    puts 'Launching ' + 'DragonLintAlpha...'.red
    puts 'Please enter which Ruby file from bin/error/ directory you would like to scan.'
    puts 'Enter "*" to scan all .rb files.'
    @file = gets.chomp
    @file_path = 'bin/error/' + @file
  end

  def read_file(file)
    puts 'Opening .rb file...'.yellow
    if file[-3, 3] != '.rb'
      puts "Ruby file not found. The specified path '#{file}' does not end with .rb".red
      exit
    else
      begin
        puts "Total lines of code to be checked within '#{file}': #{File.open(file).readlines.size}".yellow
        puts 'Searching for linting errors...'.yellow
      rescue StandardError
        puts "Unable to open file '#{file}' please ensure specified path given is correct.".red
        exit
      end
    end
    display_results(file)
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def display_results(file)
    puts ' '
    puts '---------'
    puts "Errors inside of #{file}:".cyan
    puts '---------'
    test_variable_name(file).each do |key, code|
      puts "  |#{file}| Error: Syntax/VariableName(use_snake_case)".yellow
      puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code}".red
      puts '  ---------'
    end
    test_method_name(file).each do |key, code|
      puts "  |#{file}| Error: Syntax/MethodName(use_snake_case)".yellow
      puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code}".red
      puts '  ---------'
    end
    test_class_name(file).each do |key, code|
      puts "  |#{file}| Error: Syntax/ClassName(UsePascalCase)".yellow
      puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code}".red
      puts '  ---------'
    end
    test_module_name(file).each do |key, code|
      puts "  |#{file}| Error: Syntax/ModuleName(UsePascalCase)".yellow
      puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code}".red
      puts '  ---------'
    end
    puts '---------'
    puts ' '
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize

  def read_all
    file_names = Dir['./bin/error/*.rb'].map { |path| path[12, path.size] }
    file_names.each do |file|
      read_file('bin/error/' + file)
      @each_variable_name_error = {}
      @each_method_name_error = {}
      @each_class_name_error = {}
      @each_module_name_error = {}
    end
  end

  def run
    launch
    read_file(@file_path) unless @file == '*'
    read_all if @file == '*'
  end
end

lint = Linter.new
lint.run
