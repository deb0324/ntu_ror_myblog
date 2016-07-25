class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  def author?(id)
    self == Post.find(id).user
  end

  validates :username, :nickname, :password, presence: true
  validates :username, :nickname, length: { minimum: 1 }
  validates :username, :nickname, length: { maximum: 20 }
  validates :password, length: {minimum: 5}

  validates :username, :nickname, uniqueness: true
  #validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters is allowed" }
end