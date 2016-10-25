require 'spec_helper'
require_relative '../location'
require 'httparty'
require 'json'
require 'pry'

describe Location do
  describe '#cached?' do
    context 'when zipcode has cached data' do
      it 'returns true' do
        File.write('27713.json', '{}')

        location = Location.new('27713')

        expect(location.cached?).to eq true
      end
    end

    context 'when zipcode data is not cached' do
      it 'returns false' do
        File.delete('12345.json') if File.exists?('12345.json')

        location = Location.new('12345')

        expect(location.cached?).to eq false
      end
    end

    # context '#load_from_cache' do
    #   it 'loads data from file system' do
    #     expect(File.read('27713.json')).not_to be_empty
    #   end
    # end
    #
    # context '#request_from_api' do
    #   it 'gets data through an HTTP api request' do
    #     expect(HTTParty.get('http://api.wunderground.com/api/ac9b002a66b73a2f/conditions/forecast10day/astronomy/alerts/currenthurricane/q/27713.json').parsed_response).not_to be_empty
    #   end
  end
end

#
#
#
#
#     context 'when given a valid zip code that does not exist' do
#       it 'returns false' do
#
#       end
#     end
#
#     context 'when given an invalid zip code' do
#       it 'returns false' do
#
#       end
#     end
#   end
#
#
#
#
#
#
#   describe '#current_conditions' do
#     context 'when given a valid zip code' do
#       it 'returns the current conditions' do
#         location = Location.new
#
#
#
#
#
#     context 'when given an invalid zip code' do
#       it 'returns nil' do
#         weather = Location.new
#
#         expect(weather.get('key')).to eq nil
#       end
#     end
#   end
#
#   describe '#ten_day_forecast' do
#
#   end
