class Post < ActiveRecord::Base
  has_many :connections
  has_many :comments
  has_many :categories, through: :connections
  belongs_to :user
  has_many :votes, as: :votable 

  validates :title, presence: true
  validates :content, presence: true
  validates :title, length: { minimum: 2 }
  validates :content, length: { minimum: 2 }

  def up_votes
    self.votes.where(vote: true).length
  end

  def down_votes
    self.votes.where(vote: false).length
  end

  def total_votes
    up_votes - down_votes
  end

  def total_comments
    self.comments.length
  end

  def total_tags
    self.categories.length
  end
end