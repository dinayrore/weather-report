require 'httparty'
require 'pry'
#
class Location
  def initialize(zipcode)
    if cached?(zipcode)
      load_from_cache(zipcode)
    else
      request_from_api(zipcode)
    end
  end

  def cached?(zipcode)
    File.exist?(zipcode)
  end

  def load_from_cache(zipcode)
    @data = File.read(zipcode)
  end

  def request_from_api(zipcode)
    api_key = 'ac9b002a66b73a2f'

    url = "http://api.wunderground.com/api/#{api_key}/conditions/forecast10day/astronomy/alerts/currenthurricane/q/#{zipcode}.json"

    @data = HTTParty.get(url).parsed_response

    cache(zipcode, @data)
  end

  def cache(zipcode, data)
    file = File.new("#{zipcode}.json", 'w')
    file.write(data)
    file.close
  end

  def current_conditions
    data = @data['current_observation']

    puts "Weather: #{data['weather']}"
    puts "Temperature (Fahrenheit): #{data['temp_f']}"
    puts "Humidity: #{data['relative_humidity']}"
    puts "Wind Speed (mph): #{data['wind_mph']}"
    puts "Pressure (mb): #{data['pressure_mb']}"
    puts "Dewpoint (Fahrenheit): #{data['dewpoint_f']}"
    puts "Heat Index (Fahrenheit): #{data['heat_index_f']}"
    puts "Windchill (Fahrenheit): #{data['windchill_f']}"
    puts "Feels Like (Fahrenheit): #{data['feelslike_f']}"
    puts "Visibility (mi): #{data['visibility_mi']}"
    puts "UV: #{data['UV']}"
    puts "Precipitation (in): #{data['precip_today_in']}"
  end


  def forecast

  end

  def astronomy

  end

  def alerts
    puts @data['alerts']
  end

  def current_hurricane
    hurricane = @data['currenthurricane'][0]['stormInfo']['stormName_Nice']
    puts "Current Hurricane: #{hurricane}"
  end
end
