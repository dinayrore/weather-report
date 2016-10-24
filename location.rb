require 'httparty'
require 'json'

#
class Location
  def initialize(zipcode)
    if has_cached(zipcode)
      load_from_cache(zipcode)
    else
      request_from_api(zipcode)
    end
  end

  def has_cached(zipcode)
    # TODO: does a file exist on the file system for this zipcode boolean true or false
    File.exist?(zipcode)
  end

  def load_from_cache(zipcode)
    # TODO: load data from file system
    @data = JSON.parse(File.read(zipcode))
  end

  def request_from_api(zipcode)
    api_key = 'ac9b002a66b73a2f'

    # /forecast10day/astronomy/alerts/currenthurricane
    url = "http://api.wunderground.com/api/#{api_key}/conditions/q/#{zipcode}.json"

    @data = HTTParty.get(url).parsed_response

    # cache(zipcode, @data)
  end

  def cache(zipcode, data)
    # TODO: write data to the file system
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
