require 'csv'

CSV.foreach('data/examples.csv').each_line do |l|
  puts l[0]
  puts l[1]
end
