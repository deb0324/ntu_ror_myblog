class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: "User"
  belongs_to :votable, polymorphic: true

  validates_uniqueness_of :creator, scope: [:votable_type, :votable_id]
end