require 'json'
require 'net/http'
require 'pry'

module RosterManagement
  # https://gist.github.com/justinxreese
  class Person
    attr_accessor :first_name, :last_name, :teacher

    def initialize(atts)
      @first_name, @last_name = atts['name'].split(' ')
      @teacher = false
    end

    def it_me?(person_string)
      first, last = person_string.split(' ')
      first_name == first and last_name == last
    end

    def display
      puts "Person"
    end
  end

  class Student < Person
    attr_accessor :classname

    def initialize(atts)
      super(atts)
      @classname = atts["talk"]["topic"]
    end

    def display(f)
      f.puts "#{classname} Student: #{first_name} #{last_name}"
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

  def store_person(person, teacher_status = false)
    person = teacher_status ? Teacher.new(person) : Student.new(person)

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
    store_person(sandi, true)
  end

  def collect_students(roster)
    students = roster.reject{|s| s['name'] == 'Sandi Metz'}

    students.each do |student|
      store_person(student)
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
