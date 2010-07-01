class Tournament < ActiveRecord::Base
  has_many :rankings
  has_many :users, :through => :rankings
  validates_presence_of :name
  belongs_to :user
  after_create :create_initial_owner_ranking
  
  def owner
    self.user
  end
  
  def owner=(user)
    self.user = user
  end
  
  private
  
  def create_initial_owner_ranking
    Ranking.create(:user_id => self.owner.id, :tournament_id => self.id, :rank => 1)
  end
end
