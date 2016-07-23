class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  def author?(id)
    self == Post.find(id).user
  end

  #validates :username, :nickname, presence: true
  #validates :name, length: { minimum: 2 }
  #validates :name, length: { maximum: 10 }

  #validates :name, uniqueness: true
  #validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters is allowed" }
end