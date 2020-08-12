module ReadAll
  def read_all
    file_names = Dir['./bin/error/*.rb'].map { |path| path[12, path.size] }
    file_names.each do |file|
      read_file('bin/error/' + file)
      @each_variable_name_error = {}
      @each_method_name_error = {}
      @each_class_name_error = {}
      @each_module_name_error = {}
      @each_trailing_space_error = {}
      @each_empty_line_error = {}
    end
  end
end
