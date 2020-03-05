# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trips', type: :request do
  let(:user) { create(:user) }
  let(:trip) { create(:trip) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully rating for trip' do
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id,
                     rating: 4 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the posted rating' do
      expect(response_json["rating"]).to eq 4
    end
  end

  describe 'Cannot rate a trip twice' do
    let!(:rating) { create(:rating, trip_id: trip.id, user_id: user.id) }
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id,
                     rating: 4 }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 403
    end

    it 'returns the posted rating' do
      expect(response_json["error"]).to eq "Trip already rated by this"
    end
  end


  describe 'Cant rate trip when no trip.id is sent in' do
    before do
      post '/api/v1/ratings',
           params: { trip: trip.id }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns the posted rating' do
      expect(response_json["error"][0]).to eq "Rating can't be blank"
    end
  end
end
