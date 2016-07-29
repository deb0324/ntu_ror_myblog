class Category < ActiveRecord::Base
  has_many :connections
  has_many :posts, through: :connections

  validates :title, presence: true
  validates :title, length: {minimum: 1}
  validates :title, length: {maximum: 20}
end