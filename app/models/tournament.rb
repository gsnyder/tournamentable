class Tournament < ActiveRecord::Base
  belongs_to :user
  has_many :rankings
  has_many :users, :through => :rankings

  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :create_initial_owner_ranking

  alias_attribute :owner, :user
  
  private

  def create_initial_owner_ranking
    Ranking.create(:user_id => self.owner.id, :tournament_id => self.id)
  end
end
