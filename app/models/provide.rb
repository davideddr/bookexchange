class Provide < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  scope :delivered, -> { where(delivered: true) }
end
