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

  def set_roster(roster_function)
    @roster = {}
    collect_roster(roster_function.call, 'Sandi Metz')
  end

  def collect_roster(roster, teacher_name = false)
    roster.each do |teacher|
      is_teacher = (teacher['name'] == teacher_name) && teacher_name
      store_person(teacher, is_teacher)
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
