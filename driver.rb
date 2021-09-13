require_relative 'student'
require_relative 'course'
require_relative 'taken_course'


def read_students(path)
  puts 'reading students ...'
  students = {}
  File.open(path+'\students.txt')
      .reject { |ln| ln.start_with? '#'}
      .map    { |ln| Student.new ln}
      .each   { |s| students[s.id] = s}
  students
end

def read_courses(path)
  puts 'reading courses ...'
  courses = {}
  File.open(path+'\courses.txt')
      .reject { |ln| ln.start_with? '#'}
      .map    { |ln| Course.new ln }
      .each   { |c| courses[c.code] = c }
  courses
end

def read_grades(path, students_map, courses_map)
  puts 'reading courses ...'
  File.open(path+'\grades.txt')
      .reject {|ln| ln.start_with? '#'}
      .map(&:chomp)
      .map do |ln|
    tokens = ln.split(', ')
    s = students_map[tokens[0].to_i]
    c = courses_map[tokens[1]]
    g = TakenCourse.new student: s, course: c, points: tokens[2].to_i, semester: tokens[3], instructor: tokens[4]
    s.grades << g
  end
end

def process_data(students, courses)
  top3 = students.values.sort.reverse[0..2]
  puts "Top 3 students:"
  top3.each { |s| puts "#{s.name} #{s.surname} -> #{s.average}" }

  topEntry = students
                  .values
                  .map(&:grades)
                  .flatten
                  .group_by{|g| g.course.department_code}
                  .map { |dept, grades_list| [dept, grades_list.length] }
                  .max_by {|entry| entry[1]}
  puts "Most frequented department"
  p topEntry
end

def go
  path = '.\data'
  students = read_students path
  courses = read_courses path
  read_grades path, students, courses

  puts "---------------"

  process_data students, courses
end

go

