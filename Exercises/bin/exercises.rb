require './roster_management'
# https://gist.github.com/justinxreese

roster_download = -> {
  uri = URI('http://abstractions.io/api/speakers.json')
  req = Net::HTTP.get(uri)
  roster = JSON.parse(req)
}

set_roster roster_download
f = File.open('roster.txt', 'w')

roster.each do |_, person|
  person.display(f)
end

# https://github.com/justinxreese/March-28
