puts 'Ward Check'

require 'ward'
require 'pry'

ward = Ward.new
ward.find('1 N. State St., Chicago, Il 60602')

binding.pry

puts ward.to_s
