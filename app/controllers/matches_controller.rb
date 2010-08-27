class MatchesController < ApplicationController
  # GET /tournament/:tournament_id/matches
  # GET /tournament/:tournament_id/matches.xml
  def index
    @matches = Match.all
    @tournament = Tournament.find(params[:tournament_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  # POST /tournament/:tournament_id/matches
  # POST /tournament/:tournament_id/matches.xml
  def create
    @match = Match.new(params[:match])
    @tournament = Tournament.find(params[:tournament_id])

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
end
