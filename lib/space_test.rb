module SpaceTest
  def test_if_trailing_space(input)
    input.chop[-1] == ' '
  end

  def test_trailing_space(file)
    line_number = 0
    File.open(file, 'r').each_line do |line|
      line_number += 1
      @each_trailing_space_error[line_number] = line.strip if test_if_trailing_space(line) == true
    end
    @each_trailing_space_error
  end
end
