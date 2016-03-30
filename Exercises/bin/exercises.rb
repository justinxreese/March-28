require './roster_management'
# https://gist.github.com/justinxreese

set_roster

roster.each do |_, person|
  person.display
end
