class User < ActiveRecord::Base
  has_many :rankings
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  attr_accessible :email, :password, :password_confirmation
end
