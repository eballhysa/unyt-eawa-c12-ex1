class Course
  attr_accessor :code, :title, :credits, :department_code

  def initialize(line)
    tokens = line.chomp.split(', ')
    @code = tokens[0]
    @title = tokens[1]
    @credits = tokens[2].to_i
    @department_code = tokens[3].downcase.to_sym
  end
end