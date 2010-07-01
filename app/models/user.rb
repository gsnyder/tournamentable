class User < ActiveRecord::Base
  has_many :rankings
  has_many :tournaments, :through => :rankings
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  attr_accessible :email, :password, :password_confirmation
end
