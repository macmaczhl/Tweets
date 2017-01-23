# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when authorized user' do
      it 'redirects to tweets page' do
        sign_in user
        get :index
        expect(response).to redirect_to tweets_path(user)
      end
    end

    context 'when anonymous user' do
      it 'has a 200 status' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
