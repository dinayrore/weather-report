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
    day = @data['forecast']['txt_forecast']['forecastday']
    puts "Ten Day Forecast: \n #{day[0]['title']} - #{day[0]['fcttext']} \n " \
    "#{day[2]['title']} - #{day[2]['fcttext']} \n " \
    "#{day[4]['title']} - #{day[4]['fcttext']} \n " \
    "#{day[6]['title']} - #{day[6]['fcttext']} \n " \
    "#{day[8]['title']} - #{day[8]['fcttext']} \n " \
    "#{day[10]['title']} - #{day[10]['fcttext']} \n " \
    "#{day[12]['title']} - #{day[12]['fcttext']} \n " \
    "#{day[14]['title']} - #{day[14]['fcttext']} \n " \
    "#{day[16]['title']} - #{day[16]['fcttext']} \n " \
    "#{day[18]['title']} - #{day[18]['fcttext']} "
  end

  def astronomy
    sunrise = @data['moon_phase']['sunrise']
    sunset = @data['moon_phase']['sunset']

    puts "Sunrise: #{sunrise['hour'].to_i}:#{sunrise['minute'].to_i}AM"
    puts "Sunset: #{sunset['hour'].to_i}:#{sunset['minute'].to_i}PM"
  end

  def alerts
    puts "Alerts: #{@data['alerts']}"
  end

  def current_hurricane
    hurricane = @data['currenthurricane'][0]['stormInfo']['stormName_Nice']
    puts "Hurricane: #{hurricane}"
  end
end
