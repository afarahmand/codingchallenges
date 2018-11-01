require File.expand_path('code/hotel_parser')

describe HotelParser do
  describe '.parse' do
    subject { HotelParser.parse(File.expand_path('data/hotel.yaml')) }

    it 'allows accessing via []' do
      expect(subject['hotels'].last['rooms'].first['amenities'].last).to eq 'Pool'
    end

    it 'allows accessing via []' do
      expect(subject['hotels'].first['rooms'].first['amenities'].last).to eq 'Fitness'
    end

    it 'allows accessing via method calls' do
      expect(subject.hotels.last.rooms.first.amenities.last).to eq 'Pool'
    end

    it 'allows accessing via method calls' do
      expect(subject.hotels.first.rooms.first.amenities.last).to eq 'Fitness'
    end
  end
end