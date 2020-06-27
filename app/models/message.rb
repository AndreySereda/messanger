class Message < ApplicationRecord
  belongs_to :user_chat
  validates :text, presence: true
end
