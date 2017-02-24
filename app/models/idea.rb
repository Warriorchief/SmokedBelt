class Idea < ApplicationRecord
  belongs_to :user
  has_many :users, through: :like
  has_many :likes, dependent: :destroy
  validates :content, presence: true
end
