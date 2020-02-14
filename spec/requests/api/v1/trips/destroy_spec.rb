# frozen_string_literal: true

RSpec.describe 'DESTROY /api/v1/trip', type: :request do
  let(:trip) { create(:trip) }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Successfully deletes activity type and activities' do
    before do
      delete '/api/v1/trips',
             params: { trip: trip.id }, headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
