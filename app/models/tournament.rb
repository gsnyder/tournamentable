class Tournament < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  has_many :rankings
  alias_attribute :owner, :user
end
