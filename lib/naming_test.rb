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

  def test_if_snake_case(input)
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
end
