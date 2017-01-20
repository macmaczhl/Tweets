# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'database' do
    describe 'attributes' do
      it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:provider).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:uid).of_type(:string).with_options(null: false) }
    end

    describe 'indexes' do
      it { is_expected.to have_db_index(:email).unique(true) }
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:tweets) }
  end

  describe '.from_omniauth' do
    subject(:auth) { Hashie::Mash.new(provider: user.provider, uid: user.uid) }
    let(:do_call) { described_class.from_omniauth(auth) }

    context 'when user already exist' do
      let(:user) { create(:user) }

      it 'takes correct user' do
        result = do_call
        expect(result).to eq user
      end
    end

    context 'when user does not exist' do
      let(:user) { build(:user) }

      it 'creates new user with email' do
        auth[:info] = { email: user.email }
        expect { do_call }
          .to change { User.where(email: user.email, provider: user.provider, uid: user.uid).count }
          .from(0)
          .to(1)
      end

      let(:nickname) { 'nickname' }
      it 'creates new user with nickname' do
        auth[:info] = { nickname: nickname }
        expect { do_call }
          .to change { User.where(email: nickname).count }
          .from(0)
          .to(1)
      end
    end
  end
end
