class Student
  include Comparable
  attr_accessor :id, :name, :surname, :department_code, :gender, :email, :grades

  GENDERS_MAP = {'F' => :female, 'M' => :male}

  def initialize(line)
    tokens = line.chomp.split(', ')
    @id = tokens[0].to_i
    @name = tokens[1]
    @surname = tokens[2]
    @department_code = tokens[3].downcase.to_sym
    @email = tokens[5]
    @gender = GENDERS_MAP[tokens[4]]
    @grades = []
  end

  def average
    total_points = grades.map { |g| g.points * g.course.credits }.reduce(0, :+)
    total_credits = grades.map(&:course).map(&:credits).reduce(0, :+);
    total_points / total_credits.to_f
  end

  def <=> (other)
    return self.average <=> other.average
  end
end