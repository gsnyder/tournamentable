class Ranking < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  
  validates_presence_of :rank
end
