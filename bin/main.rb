#!/usr/bin/env ruby
require_relative '../lib/naming_test.rb'
require_relative '../lib/string_colors.rb'
require_relative '../lib/read_all.rb'
require_relative '../lib/space_test.rb'
require_relative '../lib/launch_linter.rb'

lint = LaunchLinter.new
lint.run
