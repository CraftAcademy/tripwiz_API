require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter 'app/controllers/api/v1/hotels_controller.rb'
end