class Idea < ApplicationRecord

  belongs_to :user

  has_many :comments, lambda {order(created_at: :desc)}, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :members, dependent: :destroy
  has_many :membered, through: :members, source: :user

  validates :title, presence: true
  validates :body, presence: true
end
