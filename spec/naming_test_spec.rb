require 'rspec'
require './lib/naming_test.rb'

describe NamingTest do
  include NamingTest

  describe '#test_if_variable_name' do
    it 'returns false if given a string that contains def' do
      expect(test_if_variable_name('def example_method')).to be false
    end

    it 'returns false if given a string that contains end' do
      expect(test_if_variable_name('end')).to be false
    end

    it 'returns false if given a string that contains the word "module"' do
      expect(test_if_variable_name('module ExampleModule')).to be false
    end

    it 'returns false if given a string that contains class' do
      expect(test_if_variable_name('class ExampleClass')).to be false
    end

    it 'returns true if given a sring with 1 equals sign' do
      expect(test_if_variable_name('gfdgjkdf = gfdjklgdf')).to be true
    end

    it 'returns false if given a sring with a double equals sign' do
      expect(test_if_variable_name('gfdgjkdf == gfdjklgdf')).to be false
    end
  end
end
