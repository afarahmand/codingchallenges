require 'bunny'

class Rabbitmq
  # This exercise is to build a method that implement Publish/Subscribe model using RabbitMQ (Messaging Service) and Bunny gem (RabbitMQ Client).
  #
  # The test case will provide a guest name to your method. The method should subscribe to a queue, publish the provided guest to the queue, and then
  # return a string with guest's name. (e.g.: "Received Name's Reservation")
  #
  # The test is pretty basic, but we are looking to see a working Pub/Sub implementation using RabbitMQ.
  #
  # Source (https://www.rabbitmq.com/getstarted.html, http://rubybunny.info/articles/getting_started.html)
  #
  def self.reservation_pub_sub(guest)
    response = ""

    connection = Bunny.new(automatically_recover: false)
    connection.start

    channel = connection.create_channel
    reservations_queue = channel.queue('reservations')

    reservations_queue.subscribe(block: false) do |_delivery_info, _properties, body|
      response = "Received #{body}'s Reservation"
    end

    channel.default_exchange.publish(guest, routing_key: reservations_queue.name)
    # puts "[publisher] Sent #{guest}'s Reservation"

    # I feel like there might be a better\more proper way to handle delaying for the async call than the loop below
    #   I looked around a little bit online and it seems like Ruby does not have promises like JavaScript.
    until response != ""
    end

    connection.close
    response
  end
end
