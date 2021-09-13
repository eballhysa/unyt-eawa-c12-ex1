class TakenCourse
  attr_accessor :student, :course, :points, :semester, :instructor

  def initialize(params)
    @student = params[:student]
    @course = params[:course]
    @points = params[:points]
    @semester = params[:semester]
    @instructor = params[:instructor]
  end
end