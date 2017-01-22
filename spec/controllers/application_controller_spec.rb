# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it 'redirects to root page after sign out' do
    expect(controller.__send__(:after_sign_out_path_for, nil)).to eq root_path
  end
end
