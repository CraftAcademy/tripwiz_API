
module ActivityCreator
  def create_activities(activity_type, activity_visits, search_keyword)
    @activities = []
    @activity_type = activity_type
    @activity_visits = activity_visits
    @search_keyword = search_keyword
    @radius = 3000

    while @radius < 10_000
      result = get_activities

      if result.length < @activity_visits.to_i
        increase_radius
      else
        sorted_result = sort_by_rating(result)

        (0..@activity_visits.to_i - 1).each do |i|
          activity = add_activity(sorted_result[i])
          @activities << activity if activity.persisted?
        end
        return @activities
      end
    end
  end

  private

  def get_activities
    lat = @activity_type.trip.lat
    lng = @activity_type.trip.lng

    params = { location: "#{lat},#{lng}",
               type: @activity_type.activity_type,
               radius: @radius,
               max_price: @activity_type.max_price,
               keyword: @search_keyword,
               key: Rails.application.credentials.google_api_token }

    url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
    response = JSON.parse RestClient.get url, params: params.compact
    return response['results']
  end

  def add_activity(result_item)
    activity = Activity.create(
      name: result_item['name'],
      address: result_item['vicinity'],
      rating: result_item['rating'],
      lat: result_item['geometry']['location']['lat'],
      lng: result_item['geometry']['location']['lng'],
      activity_type_id: @activity_type.id
    )
  end

  def increase_radius
    @radius *= 1.5
  end

  def sort_by_rating(result)
    result.sort_by { |res| res['rating'].to_f }.reverse
  end
end
