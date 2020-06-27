class UserChat < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  has_many :messages
  validates :user_id, uniqueness: true
  validates :chat_id, uniqueness: true
end
