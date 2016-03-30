require 'net/http'
require 'json'

uri = URI('http://abstractions.io/api/speakers.json')
req = Net::HTTP.get(uri)
roster = JSON.parse(req)

roster.each do |student|
  puts student['name']
end
