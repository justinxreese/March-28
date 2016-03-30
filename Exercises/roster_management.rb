require 'json'
require 'net/http'

module RosterManagement
  # https://gist.github.com/justinxreese
  class Person
    attr_accessor :first_name, :last_name, :teacher

    def initialize(atts)
      @first_name = atts[:first_name]
      @last_name = atts[:last_name]
      @teacher = false
    end

    def it_me?(person_string)
      first, last = person_string.split(' ')
      first_name == first and last_name == last
    end

    def display
      puts it_me?('Justin Reese') ? "Hey, that's me! #{first_name} #{last_name}" : "That's not me."
    end
  end

  class Student < Person
    def display(f)
      f.puts "Student: #{first_name} #{last_name}"
    end
  end

  class Teacher < Person
    def initialize(atts)
      super(atts)
      @teacher = true
    end

    def display(f)
      f.puts "Teacher: ---#{first_name} #{last_name}---"
    end
  end

  def store_person(name_string, teacher_status = false)
    first, last = name_string.split(' ')
    atts = {first_name: first, last_name: last}

    person = teacher_status ? Teacher.new(atts) : Student.new(atts)

    @roster.store(next_id, person)
  end

  def set_roster
    @roster = {}
    uri = URI('http://abstractions.io/api/speakers.json')
    req = Net::HTTP.get(uri)
    roster = JSON.parse(req)

    collect_teacher(roster)
    collect_students(roster)
  end

  def collect_teacher(roster)
    sandi = roster.select{|s| s['name'] == 'Sandi Metz'}.first

    teacher_input = sandi['name']
    store_person(teacher_input, true)
  end

  def collect_students(roster)
    students = roster.reject{|s| s['name'] == 'Sandi Metz'}

    students.each do |student|
      student_input = student['name']
      store_person(student_input)
    end
  end

  def next_id
    @current_id = current_id + 1
    "id#{current_id}"
  end

  def current_id
    @current_id ||= 0
  end

  def roster
    @roster
  end
end
include RosterManagement
