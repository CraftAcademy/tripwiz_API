# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips', type: :request do
  let!(:trips) { create_list(:trip, 3) }
  3.times do
    let!(:hotels) { create_list(:hotel, 3, trip_id: trips[0].id) }
  end
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Successfully' do
    let!(:trip) { create(:trip, user_id: user.id) }
    let!(:hotel) { create(:hotel, trip_id: trip.id) }
    
    describe 'list trips belonging to that user' do
      before do
        get "/api/v1/trips", headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns 1 trip' do
        expect(response_json.length).to eq 1
      end
    end

    describe 'list all trips when not signed in' do
      before do
        get "/api/v1/trips"
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns 2 trips that have hotels' do
        expect(response_json.length).to eq 2
      end
    end
  end
end
