RSpec.describe 'POST /api/v1/hotels', type: :request do
  let!(:activity_type) { create(:activity_type) } 
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  
  describe 'User can generate hotel suggestions ' do
    let!(:activity) { create_list(:activity, 3, activity_type_id: activity_type.id) } 
    describe 'successfully' do
      before do
        WebMock.disable!
        
        post '/api/v1/hotels',
          params: { 
            budget: 5,
            trip: Trip.last.id
            }, headers: headers
      end
      
      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

#       it 'returns 3 hotels' do
#         expect(response_json.length).to eq 3
#       end

#       it 'returns hotel information' do
#         expect(response_json[0]['name']).to eq 'At Six Preferred LVX'
#       end
#     end

#     describe 'unsuccessfully' do
#       let!(:activity) { create_list(:activity,
#         3, 
#         activity_type_id: activity_type.id,
#         lat: 90.0) } 
#       before do
#         WebMock.disable!
        
#         post '/api/v1/hotels',
#           params: { 
#             budget: 5,
#             trip: Trip.last.id
#             }
#       end
      
#       it 'returns a 400 response status' do
#         expect(response).to have_http_status 400
#       end

#       it 'returns a error message' do
#         expect(response_json['error']).to eq "No hotels found, try a different hotel rating or location."
#       end

    end

  end
end