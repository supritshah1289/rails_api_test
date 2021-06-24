class User < ActiveRecord::Base
  has_one_attached :image
  has_many :posts
  has_many :comments
end
