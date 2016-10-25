require 'httparty'
require 'json'
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
    @data = JSON.parse(File.read(zipcode))
  end

  def request_from_api(zipcode)
    api_key = 'ac9b002a66b73a2f'

    # /forecast10day/astronomy/alerts/currenthurricane
    url = "http://api.wunderground.com/api/#{api_key}/conditions/q/#{zipcode}.json"

    @data = HTTParty.get(url).parsed_response

    cache(zipcode, @data)
  end

  def cache(zipcode, data)
    binding.pry
    file = File.new("#{zipcode}", 'w')
    file.puts(data)
    file.close
  end

  def current_conditions
    # if @data.key? 'current_conditions'
    #   @data['current_conditions']
    # end
  end

  #
  # def forecast
  #
  # end
  #
  # def astronomy
  #
  # end
  #
  # def alerts
  #
  # end
  #
  # def current_hurricane
  #
  # end
end
