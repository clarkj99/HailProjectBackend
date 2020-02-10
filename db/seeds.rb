require "csv"
require "time"
require "open-uri"

Report.destroy_all
today = Time.now

def city_name(city)
  # Remove unwanted number and direction from city
  # city_name("6 SE ATLANTA") => "ATLANTA"

  directions = ["N", "S", "E", "W", "NE", "NW", "SE", "SW", "NNE", "ENE", "ESE", "SSE", "NNW", "WNW", "WSW", "SSW"]
  city_array = city.split(" ")
  if (city_array[0].to_i.to_s == city_array[0])
    city_array.shift
  end
  if ((city_array & directions).length > 0)
    city_array.shift
  end
  city_array.join(" ")
end

def get_csv(date)
  filename = "http://www.spc.noaa.gov/climo/reports/" + date.strftime("%y%m%d") + "_rpts_hail.csv"
  csvfile = open(filename)
  puts "--------------- " + filename + " --------------"

  csv = CSV.parse(csvfile, { :headers => true, :liberal_parsing => true })
  csv.each do |row|
    time = row[0]
    size = row[1]
    location = row[2]
    city = city_name(row[2])
    county = row[3]
    state = row[4]
    lat = row[5]
    lon = row[6]
    comments = row[7]

    puts DateTime.new(date.to_date.year, date.to_date.month, date.to_date.mday, time[0..1].to_i, time[2..3].to_i)
  end
end

10.times do |i|
  get_csv(Date.today.prev_day(i))
end
