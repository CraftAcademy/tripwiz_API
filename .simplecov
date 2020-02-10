require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter 'app/controllers/api/v1/hotels_controller.rb'
   add_filter 'app/channels'
   add_filter 'app/jobs'
   add_filter 'app/mailers'
end