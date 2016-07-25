class Gallery < ActiveRecord::Base
  has_many :frames
  belongs_to :user
end