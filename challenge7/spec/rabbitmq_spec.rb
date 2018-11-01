require File.expand_path('code/rabbitmq')

describe Rabbitmq do
  describe '.reservation_pub_sub' do
    %w[Jason Motti Ganesh Shiju Jongmyung].each do |guest|
      context "#{guest} book a reservation" do
        subject { Rabbitmq.reservation_pub_sub(guest) }

        it { is_expected.to eq "Received #{guest}'s Reservation" }
      end
    end
  end
end
