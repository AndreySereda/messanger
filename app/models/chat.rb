class Chat < ApplicationRecord
  has_many :user_chats
  validates :title, presence: true
end
