RSpec.describe 'DESTROY /api/v1/trip', type: :request do
  let(:trip) { create(:trip) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Successfully deletes trip' do
    before do
      delete '/api/v1/trips',
             params: { trip: trip.id }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Successfully deletes trip and its activities, hotels and restaurants' do
    3.times do
      let!(:trip_hotels) { create_list(:hotel, 3, trip_id: trip.id) }
    end
    let!(:activity_type) { create(:activity_type, trip_id: trip.id) }
    let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }
    before do
      delete '/api/v1/trips',
             params: { trip: trip.id }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end