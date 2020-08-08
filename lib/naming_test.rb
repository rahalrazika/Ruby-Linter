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
end
