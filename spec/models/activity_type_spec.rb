RSpec.describe ActivityType, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :type }
    it { is_expected.to have_db_column :trip_id }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :trip }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:activity_type)).to be_valid
    end
  end
end


