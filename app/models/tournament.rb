class Tournament < ActiveRecord::Base
  belongs_to :user
  has_many :rankings

  validates_presence_of :name
  validates_uniqueness_of :name

  alias_attribute :owner, :user
end
