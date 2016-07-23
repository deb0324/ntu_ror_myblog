class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  #validates :content, presence: true
  #validates :content, length: { minimum: 2 }
end