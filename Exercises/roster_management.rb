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
    def display
      puts "Student: #{first_name} #{last_name}"
    end
  end

  class Teacher < Person
    def initialize(atts)
      super(atts)
      @teacher = true
    end

    def display
      puts "Teacher: ---#{first_name} #{last_name}---"
    end
  end

  my_name = 'Justin Reese'

  # https://gist.github.com/justinxreese
  def store_person(name_string, teacher_status = false)
    first, last = name_string.split(' ')
    atts = {first_name: first, last_name: last}

    person = teacher_status ? Teacher.new(atts) : Student.new(atts)

    @roster.store(next_id, person)
  end

  def set_roster
    @roster = {}
    collect_teacher
    collect_students
  end

  def collect_teacher
    puts 'Enter the teacher'
    teacher_input = gets
    store_person(teacher_input, true)
  end

  def collect_students
    puts 'Enter a student'
    n = 1

    while student_input = gets
      n += 1
      break if student_input.strip == 'stop'
      store_person(student_input)
      puts 'Enter a student or ^D to exit'
    end

    puts "#{n} students collected"
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
