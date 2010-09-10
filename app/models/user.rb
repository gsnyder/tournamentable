class User < ActiveRecord::Base
  SPOTS_TO_CHALLENGE = 3

  has_many :rankings

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  def match_with(ranking)
    return nil if ranking.user == self
    
    m = Match.where(:tournament_id => ranking.tournament.id, :incumbent_id => [ranking.user.id, self.id], :challenger_id => [ranking.user.id, self.id], :winner => nil).first

    return m
  end
  
  def can_challenge?(ranking)
    return false if ranking.user == self

    my_rank = Ranking.where(:tournament_id => ranking.tournament.id, :user_id => self.id).first

    return ((my_rank.rank - ranking.rank) <= SPOTS_TO_CHALLENGE) && !(ranking.rank > my_rank.rank) ? true : false
  end
  
  def wins(tournament_id=nil)
    if tournament_id
      Match.where(:tournament_id => tournament_id, :winner => self.id).count
    else
      Match.where(:winner => self.id).count
    end
  end
  
  def wins_vs_opp(opponent_id, tournament_id=nil)
    if tournament_id
      Match.where(:tournament_id => tournament_id, :winner => self.id).where("incumbent_id = #{opponent_id} or challenger_id = #{opponent_id}").count
    else
      Match.where(:winner => self.id).where("incumbent_id = #{opponent_id} or challenger_id = #{opponent_id}").count
    end
  end
  
  def losses(tournament_id=nil)
    if tournament_id
      Match.where(:tournament_id => tournament_id).where("incumbent_id = #{self.id} or challenger_id = #{self.id}").where("winner != #{self.id}").count
    else
      Match.where("incumbent_id = #{self.id} or challenger_id = #{self.id}").where("winner != #{self.id}").count
    end
  end
  
  def losses_vs_opp(opponent_id, tournament_id=nil)
    if tournament_id
      Match.where(:tournament_id => tournament_id).where("incumbent_id = #{opponent_id} or challenger_id = #{opponent_id}").where("incumbent_id = #{self.id} or challenger_id = #{self.id}").where("winner != #{self.id}").count
    else
      Match.where("incumbent_id = #{opponent_id} or challenger_id = #{opponent_id}").where("incumbent_id = #{self.id} or challenger_id = #{self.id}").where("winner != #{self.id}").count
    end
  end
  
  def readable_name
    if first_name.blank? || last_name.blank?
      email
    else
     "#{first_name} #{last_name}"
    end
  end
end
