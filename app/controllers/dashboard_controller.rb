class DashboardController < ApplicationController
  def index
    @rankings = Ranking.where(:user_id => current_user)
  end
end
