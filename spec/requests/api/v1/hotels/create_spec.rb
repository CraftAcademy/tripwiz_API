RSpec.describe 'POST /api/v1/hotels', type: :request do
  let!(:activity_type) { create(:activity_type) } 
  let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) } 
  
  describe 'User can generate hotel suggestions ' do
    describe 'successfully' do
      before do
        WebMock.disable!
        
        post '/api/v1/hotels',
          params: { 
            rating: 5,
            trip_id: Trip.last.id
            }
      end
      
      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'returns 3 hotels' do
        expect(response_json.length).to eq 3
      end

      it 'returns hotel information' do
        expect(response_json[0]['name']).to eq 'At Six Preferred LVX'
      end
    end

  end
end