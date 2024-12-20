class Post < ApplicationRecord
  validates :title,presence: true
  has_many :liked_posts
  belongs_to :category
  belongs_to :user
end