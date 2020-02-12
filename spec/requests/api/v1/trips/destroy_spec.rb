# frozen_string_literal: true

RSpec.describe 'DESTROY /api/v1/trip', type: :request do
  let(:trip) { create(:trip) }

  describe 'Successfully deletes activity type and activities' do
    before do
      delete '/api/v1/trips',
             params: { trip: trip.id }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
