require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :trip_id }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :destination_rating }
    it { is_expected.to have_db_column :activities_rating }
    it { is_expected.to have_db_column :restaurants_rating }
    it { is_expected.to have_db_column :hotel_rating }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :trip }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:user)).to be_valid
    end
  end
end
