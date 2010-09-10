class MatchesController < ApplicationController
  # GET /tournament/:tournament_id/matches
  # GET /tournament/:tournament_id/matches.xml

  
  def index
    @tournament = Tournament.find(params[:tournament_id])
    @matches = Match.where(:tournament_id => @tournament.id, :winner => nil).all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  # POST /tournament/:tournament_id/matches
  # POST /tournament/:tournament_id/matches.xml
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @match = Match.new(params[:match])
    @match.tournament = @tournament
    
    #send challenge email
    challenger = User.find(params[:match][:challenger_id])
    incumbent = User.find(params[:match][:incumbent_id])
    body_hash = {:challenger => challenger.readable_name, 
                 :incumbent => incumbent.readable_name,
                 :tournament => @tournament.name}
    Notification.deliver_challenge_email(challenger.email,[challenger.email,incumbent.email].map{|x| %{<#{x}>} if x}.join(','),"A Ping Pong Challenge Has been Requested",body_hash)
    
    respond_to do |format|
      if @match.save
        format.html { redirect_to(@tournament, :notice => 'Match was successfully created.') }
        format.xml  { render :xml => @tournament, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /tournament/:tournament_id/matches/1
  # GET /tournament/:tournament_id/matches/1.xml
  def show
    @match = Match.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # PUT /tournament/:tournament_id/matches/1
  # PUT /tournament/:tournament_id/matches/1.xml
  def update
    @match = Match.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    
    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to(@tournament, :notice => 'Match was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament/:tournament_id/matches/1
  # DELETE /tournament/:tournament_id/matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    
    @match.destroy

    respond_to do |format|
      format.html { redirect_to(@tournament) }
      format.xml  { head :ok }
    end
  end

  def winner
    @match = Match.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    @match.winner = params[:winner_id]
    @match.save!
    
    respond_to do |format|
      if params[:winner_id].to_i == @match.challenger.id
        challenger_r = Ranking.where(:user_id => @match.challenger.id, :tournament_id => @tournament.id).first
        incumbent_r = Ranking.where(:user_id => @match.incumbent.id, :tournament_id => @tournament.id).first
        
        challenger_r_rank = challenger_r.rank
        incumbent_r_rank = incumbent_r.rank
        
        challenger_r.rank = incumbent_r_rank
        incumbent_r.rank = challenger_r_rank
        
        challenger_r.save!
        incumbent_r.save!

        format.html { redirect_to(@tournament, :notice => "We have a new winner! The challenger has won and the rankings have changed.") }
      else
        format.html { redirect_to(@tournament, :notice => "We have a winner! The incumbent has won and the rankings have not changed.") }
      end
    end
  end
end
