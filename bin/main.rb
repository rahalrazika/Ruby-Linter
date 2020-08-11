#!/usr/bin/env ruby
require_relative '../lib/naming_test.rb'
require_relative '../lib/string_colors.rb'
require_relative '../lib/read_all.rb'
require_relative '../lib/space_test.rb'

class Linter
  include NamingTest
  include ReadAll
  include SpaceTest

  def initialize()
    @each_variable_name_error = {}
    @each_method_name_error = {}
    @each_class_name_error = {}
    @each_module_name_error = {}
    @each_trailing_space_error = {}
    @each_empty_line_error = {}
  end

  def launch
    puts 'Launching ' + 'DragonLintAlpha...'.red
    puts 'Please enter which Ruby file from bin/error/ directory you would like to scan.'
    puts 'Enter "*" to scan all .rb files inside bin/error directory.'
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
  # rubocop: disable Layout/LineLength
  def display_results(file)
    puts ' '
    puts '---------'
    puts "Errors inside of #{file}:".cyan
    puts '---------'
    if test_variable_name(file) == {} && test_method_name(file) == {} && test_class_name(file) == {} && test_module_name(file) == {} && test_trailing_space(file) == {}
      puts "  No errors found inside of #{file}".green
    else
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
      test_trailing_space(file).each do |key, code|
        puts "  |#{file}| Error: Syntax/TrailingSpace(Unnecasery White Space At End Of Line)".yellow
        puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code} |<---".red
        puts '  ---------'
      end
      test_two_empty_lines(file).each do |key, code|
        puts "  |#{file}| Error: Syntax/ExtraEmptyLine(Unnecasery Extra Empty Line)".yellow
        puts '    Line: '.cyan + key.to_s.cyan + ':'.cyan + " #{code} |<---".red
        puts '  ---------'
      end
    end
    puts '---------'
    puts ' '
  end

  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Layout/LineLength

  def run
    launch
    read_file(@file_path) unless @file == '*'
    read_all if @file == '*'
  end
end

lint = Linter.new
lint.run
