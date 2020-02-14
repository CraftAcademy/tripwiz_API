# frozen_string_literal: true

RSpec.describe 'GET /api/v1/activity_types', type: :request do
  describe 'Activities' do
    let(:trip) { create(:trip) }
    let!(:activity_type) { create(:activity_type, trip_id: trip.id ) }
    let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    it 'are presented to the user' do
      get '/api/v1/activity_types',
          params: { trip: trip.id }, headers: headers

      expect(response_json[activity_type.activity_type].count).to eq 3
    end
  end
end

