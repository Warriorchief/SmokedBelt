class User < ApplicationRecord
  has_secure_password
  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea

  validates :name, presence: true
  validates :alias, presence: true
  validates :email, presence: true
  validates :email, format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "proper email format"}
  validates :email, uniqueness: { case_sensitive: false }
end
