class Ladder < Tournament
  has_many :rankings
  has_many :users, :through => :rankings
  after_create :create_initial_owner_ranking
  
  private
  
  def create_initial_owner_ranking
    Ranking.create(:user_id => self.owner.id, :tournament_id => self.id, :rank => 1)
  end
end
