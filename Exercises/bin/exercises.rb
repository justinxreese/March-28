require './roster_management'
# https://gist.github.com/justinxreese

set_roster
f = File.open('roster.txt', 'w')

roster.each do |_, person|
  person.display(f)
end

# https://github.com/justinxreese/March-28
