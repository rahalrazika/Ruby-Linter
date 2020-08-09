module NamingTest
  def test_if_variable_name(input)
    if %w[class def module == += -=].any? { |word| input.include? word }
      false
    elsif ['='].none? { |word| input.include? word }
      false
    else
      true
    end
  end

  def test_if_variable_snake_case(input)
    input_split_array = input.split('')
    index_of_equals_sign = (input_split_array.find_index { |each| each == '=' }).to_i
    cut_from_equals = (input_split_array[0, index_of_equals_sign]).join
    only_variable = cut_from_equals.strip
    if only_variable.split('').any? { |letter| letter == letter.upcase && letter != letter.downcase }
      false
    else
      true
    end
  end

  def test_variable_name(file)
    line_number = 0
    File.open(file, 'r').each_line do |line|
      line_number += 1
      if test_if_variable_snake_case(line) == false && test_if_variable_name(line) == true
        @each_variable_name_error[line_number] = line.strip.chop
      end
    end
    @each_variable_name_error
  end

  def test_if_method_name(input)
    if %w[class = module == += -=].any? { |word| input.include? word }
      false
    elsif ['def '].any? { |word| input.strip[0, 4].include? word }
      true
    else
      false
    end
  end

  def test_if_method_snake_case(input)
    strip_input = input.strip.split('')
    only_name = strip_input[4, strip_input.size].to_a
    if only_name.any? { |letter| letter == letter.upcase && letter != letter.downcase }
      false
    else
      true
    end
  end

  def test_method_name(file)
    line_number = 0
    File.open(file, 'r').each_line do |line|
      line_number += 1
      if test_if_method_snake_case(line) == false && test_if_method_name(line) == true
        @each_method_name_error[line_number] = line.strip
      end
    end
    @each_method_name_error
  end

  def test_if_class_name(input)
    if %w[def = module == += -=].any? { |word| input.include? word }
      false
    elsif ['class '].any? { |word| input.strip[0, 6].include? word }
      true
    else
      false
    end
  end

  def test_if_class_pascal_case(input)
    strip_input = input.strip.split('')
    only_name = strip_input[6, strip_input.size].to_a
    if only_name.any? { |letter| letter == '_'}
      false
    elsif only_name[0].to_s == only_name[0].to_s.upcase && only_name[0].to_s != only_name[0].to_s.downcase
      true
    else
      false
    end
  end

  def test_class_name(file)
    line_number = 0
    File.open(file, 'r').each_line do |line|
      line_number += 1
      if test_if_class_pascal_case(line) == false && test_if_class_name(line) == true
        @each_class_name_error[line_number] = line.strip
      end
    end
    @each_class_name_error
  end
end
