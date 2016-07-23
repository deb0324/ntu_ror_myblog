class Post < ActiveRecord::Base
  has_many :connections
  has_many :comments
  has_many :categories, through: :connections
  belongs_to :user

  #validates :title, presence: true
  #validates :content, presence: true
  #validates :title, length: { minimum: 2 }
  #validates :content, length: { minimum: 2 }
end