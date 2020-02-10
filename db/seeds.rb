require "csv"
require "time"
require "open-uri"

Report.destroy_all
today = Time.now

def get_csv(date)
  filename = "http://www.spc.noaa.gov/climo/reports/" + date.strftime("%y%m%d") + "_rpts_hail.csv"
  csvfile = open(filename)
  puts filename

  csv = CSV.parse(csvfile, :headers => false)
  csv.each do |row|
    puts row.to_a.join(" - ")
  end
end

get_csv(Date.new(2020, 2, 5))
