class Ranking < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  
  validates_presence_of :tournament
  validates_presence_of :user
  
  before_create :inital_rank
  
  private
  
  def inital_rank
    self.rank = Ranking.where(:tournament_id => self.tournament_id).count.to_i + 1
  end
end
