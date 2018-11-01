Company X Coding Exercises
=============================

As a candidate to our engineering team, we are offering the following exercises to allow you to showcase your development skills. The purpose of these
exercises are for you to express yourself technically outside of the in-person interview. Take as much time as you would like, but it should only take
a few hours.

Submission Instructions
-----------------------

1. Complete the exercises as described below.
  - Commit each solution separately with a brief explanation of your
    solution. Don not squash your commits.
  - Your code should be clear and well-documented.
2. When you are done, use `git bundle` to bundle up the repo and send it back to
`random_dude@companyx.com`.

Environment
-----------

Ruby 2.5.x, Rspec, Bundler, RabbitMQ

Exercises
=========

*Note: Feel free to use Google to look up syntax, method definitions, etc. but
please don't just look up the answers.* Any files you add should be added to the lib directory and required within the relevant code exercise.

Fibonacci Sequence
------------------

Implement a method that will calculate the Nth number of the Fibonacci sequence
(http://en.wikipedia.org/wiki/Fibonacci_number).

Tests have been pre-written using rspec at `/spec/fibonacci_spec.rb`. There is a Fibonacci class in `code/fibonacci.rb` the solution should be
implementation in the calculate method.

Hotel Parser
------------

With the provided YAML file in `data/hotel.yaml`, implement the hotel parser in a way that parses the file and returns a collection of nested objects
representing the data. You may use the standard YAML parser, but do not use OpenStruct. Bonus points for good OOP representation.

The object should respond to the following requirements:

1. Using the `[]` operator:
  ```
  data['hotels'].last['rooms'].first['amenities'].last => "Pool"
  ```

2. Using method calls:
  ```
  data.hotels.last.rooms.first.amenities.last => "Pool"
  ```

Tests have been pre-written using rspec in `/spec/hotel_parser_spec.rb`. There is a parse method in the HotelParser class located in
`code/hotel_parser.rb`.

RabbitMQ Pub/Sub
---------------

This exercise is to build a method that implement Publish/Subscribe model using RabbitMQ (Messaging Service) and Bunny gem (RabbitMQ Client).

The test case will provide a guest name to your method. The method should subscribe to a queue, publish the provided guest to the queue, and then
return a string with guest's name. (e.g.: "Received Name's Reservation")

We are looking to see a working Pub/Sub implementation using RabbitMQ. Avoid a common hangup, do not simply return string value to pass the test,
ensure the value has been returned by the subscription block.

(https://www.rabbitmq.com/getstarted.html, http://rubybunny.info/articles/getting_started.html)

Tests have been pre-written using rspec in `/spec/rabbitmq_spec.rb`. There is a reservation_pub_sub method in Rabbitmq located in `code/rabbitmq.rb`
