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
end
