class Gallery < ActiveRecord::Base
  has_many :frames
  belongs_to :user

  validates :title, presence: true
  validates :title, length: {minimum: 1}
  validates :title, length: {maximum: 20}
end