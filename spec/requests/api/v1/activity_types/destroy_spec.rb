# frozen_string_literal: true

RSpec.describe 'DESTROY /api/v1/activity_type', type: :request do
  let(:trip) { create(:trip) }
  let!(:activity_type) { create(:activity_type, trip_id: trip.id) }
  let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) }

  describe 'Successfully deletes activity type and activities' do
    before do
      delete '/api/v1/activity_types',
             params: { trip: trip.id }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
