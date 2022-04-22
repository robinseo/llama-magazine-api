class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :likes
  enum layout: [:top, :bottom, :left, :right]
  validates_presence_of :contents, on: :create
  validates_presence_of :layout, on: :create
  validates_presence_of :image, on: :create

  def image_url
    file_url_of(image)
  end
end
