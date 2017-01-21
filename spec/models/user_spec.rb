# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

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
      it { is_expected.to have_db_column(:oauth_token).of_type(:string) }
      it { is_expected.to have_db_column(:oauth_secret).of_type(:string) }
    end

    describe 'indexes' do
      it { is_expected.to have_db_index(:email).unique(true) }
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:tweets) }
  end

  describe '.from_omniauth' do
    let(:auth) do
      Hashie::Mash.new(provider: user.provider,
                       uid: user.uid,
                       credentials: { token: user.oauth_token, secret: user.oauth_secret })
    end
    let(:do_call) { described_class.from_omniauth(auth) }

    context 'when user already exist' do
      it 'takes correct user' do
        result = do_call
        expect(result).to eq user
      end
    end

    context 'when user does not exist' do
      let(:builded_user) { build(:another_user) }

      before do
        auth.uid = builded_user.uid
      end

      let(:user_params) do
        { email: builded_user.email,
          provider: builded_user.provider,
          uid: builded_user.uid,
          oauth_token: builded_user.oauth_token,
          oauth_secret: builded_user.oauth_secret }
      end
      it 'creates new user with email' do
        auth.info = { email: builded_user.email }
        expect { do_call }
          .to change { User.where(user_params).count }
          .from(0)
          .to(1)
      end

      let(:nickname) { 'nickname' }
      it 'creates new user with nickname' do
        auth.info = { nickname: nickname }
        expect { do_call }
          .to change { User.where(email: nickname).count }
          .from(0)
          .to(1)
      end
    end
  end

  describe '#create_client' do
    let(:user) { create(:user) }

    it 'creates client with attributes' do
      client = user.__send__ :create_client
      expect(client).to have_attributes(consumer_key: Rails.application.config.twitter_key,
                                        consumer_secret: Rails.application.config.twitter_secret,
                                        access_token: user.oauth_token,
                                        access_token_secret: user.oauth_secret)
    end
  end
end
