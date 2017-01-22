# frozen_string_literal: true
class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
end
