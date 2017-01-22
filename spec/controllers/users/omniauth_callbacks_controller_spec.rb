# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  it 'defines FLASH_MESSAGE_KIND' do
    expect(described_class::FLASH_MESSAGE_KIND).to eq 'Twitter'
  end
end
