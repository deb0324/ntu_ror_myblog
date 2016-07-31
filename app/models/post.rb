class Post < ActiveRecord::Base
  include Votable
  has_many :connections
  has_many :comments
  has_many :categories, through: :connections
  belongs_to :user
  has_many :votes, as: :votable 

  validates :title, presence: true
  validates :content, presence: true
  validates :title, length: { minimum: 2 }
  validates :content, length: { minimum: 2 }

  def total_comments
    self.comments.length
  end

  def total_tags
    self.categories.length
  end
end