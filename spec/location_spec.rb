require 'spec_helper'
require_relative '../location'

describe Location do

    # before do
    #   @location = Location.new('27701')
    # end
    #
    # describe '#initialize' do
    #   it 'loads information from the file cached' do
    #     expect(JSON.parse(File.read(@location))).to.not be nil
    #   end
    # end

  describe '#has_cached' do
    context 'when given a valid zip code that exists on the file system' do
      it 'returns true' do
        location = Location.new('27713')

        expect(File.exist?(location)).to eq true
      end
    end
  end


#   context 'when given a valid zip code that does not exist on the file system' do
#     it 'requests information from an api' do
#     end
#   end
#
#   end
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
end
