class Match < ActiveRecord::Base
  belongs_to :tournament
  
  def incumbent
    User.find(self.incumbent_id).email
  end
  
  def challenger
    User.find(self.challenger_id).email
  end
end
