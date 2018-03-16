require 'rspec'

class Hotel
  attr_accessor :guests, :occupied_rooms

  def initialize
    @guests = []
    @occupied_rooms = []
    @rooms = {}
  end

  def check_in(guest_name, room_number)
    return false if @rooms[room_number]
    @guests << guest_name
    @occupied_rooms << room_number
    @rooms[room_number] = guest_name
    true
  end

  def check_out(guest_name)
    @guests.delete guest_name
    room_number = @rooms.invert[guest_name]
    @rooms.delete room_number
    @occupied_rooms.delete room_number
  end
end

describe Hotel do
  let(:hotel) { Hotel.new }
  describe 'checking in a guest' do
    context 'room is available' do
      it 'allows check-in' do
        expect(hotel.check_in('George Harrison', 302)).to be true
      end

      it 'adds the guest to the guest list' do
        hotel.check_in('John Lennon', 301)
        expect(hotel.guests).to include 'John Lennon'
      end
    end

    context 'room is not available' do
      it 'disallows check-in' do
        hotel.check_in('Roy Orbison', 302)
        expect(hotel.check_in('George Harrison', 302)).to be false
      end

      it 'does not add guest to guest list' do
        hotel.check_in 'Roy Orbison', 302
        hotel.check_in 'George Harrison', 302
        expect(hotel.guests).not_to include 'George Harrison'
      end
    end

    it 'can check a guest out' do
      expect(hotel.guests).to eq([])
      hotel.check_in('Ringo Starr', 404)
      expect(hotel.guests).not_to eq([])
      hotel.check_out('Ringo Starr')
      expect(hotel.guests).not_to include 'Ringo Starr'
    end

    it 'checking out frees the room' do
      hotel.check_in('Ringo Starr', 404)
      hotel.check_out('Ringo Starr')
      expect(hotel.occupied_rooms).not_to include 404
      expect(hotel.check_in('John Lennon', 404)).to be true
    end
  end
end
