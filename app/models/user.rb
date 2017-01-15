class User < ActiveRecord::Base
  has_many :provides
  has_many :books
  has_many :wishlists

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :phone, length: 8..10
end
