# frozen_string_literal: true

class Api::V1::HotelsController < ApplicationController

  def create
    activity_type = ActivityType.find_by(trip_id: params[:trip])

    if activity_type.activities != []
      lats = []
      longs = []
      activity_type.activities.each do |activity|
        lats << activity['lat'].to_f
        longs << activity['lng'].to_f
      end
      avg_lat = lats.sum / lats.size
      avg_lng = longs.sum / longs.size
      lat = avg_lat.round(5)
      lng = avg_lng.round(5)
    end

    getHotels = get_hotels(params, lat, lng)
    hotels = []

    if getHotels != 'error'
      getHotels.each do |hotel|
        name = hotel['hotel']['name']
        lat = hotel['hotel']['latitude']
        lng = hotel['hotel']['longitude']
        price = hotel['offers'][0]['price']['total']
        address = hotel['hotel']['address']['lines'][0]
        url = hotel['hotel']['media'][0]['uri']
        rating = hotel['hotel']['rating']
        currency = hotel['offers'][0]['price']['currency']
        description = hotel['offers'][0]['room']['description']['text']

        hotel = Hotel.create(
          name: name,
          lat: lat,
          lng: lng,
          price: price,
          address: address,
          url: url,
          trip_id: params[:trip],
          rating: rating,
          currency: currency,
          description: description
        )
        hotels << hotel if hotel.persisted?
      end
      hotels
    end

    if hotels != []
      render json: hotels
    else
      render json: { error: 'No hotels found, try a different hotel rating or location.' }, status: 400
    end
  end

  def index
    hotels = Hotel.where(trip_id: params[:trip])
    render json: hotels
  end

  def destroy
    trip_hotels = Hotel.where(trip_id: params[:trip])
    hotels_to_discard = trip_hotels.where.not(id: params[:hotel_id])
    Hotel.destroy(hotels_to_discard.ids)
    render head: :ok
  end

  private

  def get_hotels(params, lat, lng)
    amadeus = Amadeus::Client.new(hostname: :production,
                                  client_id: Rails.application.credentials.client_id,
                                  client_secret: Rails.application.credentials.client_secret)
    begin
      response = amadeus.shopping.hotel_offers.get(latitude: lat, longitude: lng, ratings: params[:budget], radius: 3, radiusUnit: 'KM', view: 'LIGHT')
    rescue Amadeus::ResponseError => e
      return 'error'
    end
    hotels = JSON.parse(response.body)
    hotelsFinal = hotels['data'].slice(0, 3)
  end
end
