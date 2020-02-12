# frozen_string_literal: true

RSpec.describe 'POST /api/v1/activity_type', type: :request do
  let(:trip) { create(:trip) }
  let!(:activity_type) { create(:activity_type, trip_id: trip.id) }
  let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }

  describe 'Successfully creates activity type' do
    before do
      get_google_places_nightclubs_success
      put '/api/v1/activity_types',
          params: { activity_type: 'night_club',
                    activity_visits: 3,
                    trip: trip.id }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 3 activities' do
      expect(response_json.length).to eq 3
    end

    it 'activities are sorted by rating' do
      expect(response_json[0]['rating']).to eq '3.2'
    end
  end

  describe 'Successfully creates activity type' do
    before do
      put '/api/v1/activity_types',
          params: { activity_type: 'museum',
                    activity_visits: 2,
                    trip: trip.id }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 2 activities' do
      expect(response_json.length).to eq 2
    end

    it 'activities are sorted by rating' do
      expect(response_json[0]['rating']).to eq '3.2'
    end
  end
end
