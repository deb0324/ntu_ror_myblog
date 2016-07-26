class Frame < ActiveRecord::Base
  belongs_to :gallery
  mount_uploader :image, ImageUploader

  validates :name, :image, presence: true
  validates :name, length: { minimum: 1 }
  validates :name, length: { maximum: 20 }
end