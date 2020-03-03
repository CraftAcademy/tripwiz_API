require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :trip_id }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :rating }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :trip }
  end
end
