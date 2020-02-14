# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trips', type: :request do
  let!(:trip) { create_list(:trip, 3) }

  describe 'Succesfully lists trip information' do
    before do
      get "/api/v1/trips"
    end

    it 'and returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'and returns 3 trip id' do
      binding.pry
      expect(response_json.length).to eq 3
    end
  end
end
