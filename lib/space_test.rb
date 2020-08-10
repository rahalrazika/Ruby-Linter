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

  def test_if_empty_line(input)
    input.chop == ''
  end

  def test_two_empty_lines(file)
    line_number = 0
    empty_line_count = 0
    File.open(file, 'r').each_line do |line|
      line_number += 1
      if test_if_empty_line(line) == true
        empty_line_count += 1
        @each_empty_line_error[line_number] = line.strip if empty_line_count == 2
      else
        empty_line_count = 0
      end
    end
    @each_empty_line_error
  end
end
