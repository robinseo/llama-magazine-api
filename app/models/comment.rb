class Comment < ApplicationRecord
  belongs_to :record, polymorphic: true
  belongs_to :user
  validates_presence_of :content
end
