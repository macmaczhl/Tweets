# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  context 'database' do
    describe 'attributes' do
      it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:text).of_type(:string) }
      it { is_expected.to have_db_column(:image).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    end

    describe 'indexes' do
      it { is_expected.to have_db_index(:user_id) }
    end
  end
end
