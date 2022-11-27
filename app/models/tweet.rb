class Tweet < ApplicationRecord
  belongs_to :user

  validates :message, length: { maximum: 140 }, presence: true
  validates :user_id, presence: true
end