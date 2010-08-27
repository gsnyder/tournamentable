class User < ActiveRecord::Base
  has_many :rankings

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
  
  def match_with(ranking)
    return nil if ranking.user == self
    
    m = Match.where(:tournament_id => ranking.tournament.id, :incumbent_id => [ranking.user.id, self.id], :challenger_id => [ranking.user.id, self.id]).first

    return m
  end
  
  def can_challenge?(ranking)
    return false if ranking.user == self

    my_rank = Ranking.where(:tournament_id => ranking.tournament.id, :user_id => self.id).first

    return ((ranking.rank - my_rank.rank) < 3) && !(ranking.rank > my_rank.rank) ? true : false
  end
end
