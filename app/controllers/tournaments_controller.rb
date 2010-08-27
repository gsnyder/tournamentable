class TournamentsController < ApplicationController
  # GET /tournaments
  # GET /tournaments.xml
  def index
    @tournaments = Tournament.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.xml
  def show
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.xml
  def new
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
  end

  # POST /tournaments
  # POST /tournaments.xml
  def create
    @tournament = Tournament.new(params[:tournament])
    
    @tournament.owner = current_user
    
    respond_to do |format|
      if @tournament.save
        format.html { redirect_to(@tournament, :notice => 'Tournament was successfully created.') }
        format.xml  { render :xml => @tournament, :status => :created, :location => @tournament }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.xml
  def update
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to(@tournament, :notice => 'Tournament was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.xml
  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy

    respond_to do |format|
      format.html { redirect_to(tournaments_url, :notice => 'Tournament was deleted.') }
      format.xml  { head :ok }
    end
  end
  
  # GET /tournaments/1/join
  def join
    tournament = Tournament.find(params[:id])
    ranking = Ranking.new(:user => current_user, :tournament => tournament)

    respond_to do |format|
      if ranking.save
        format.html { redirect_to(tournament, :notice => "You've joined the tournament!") }
      else
        format.html { redirect_to(tournament, :notice => "Something's wrong. You can't join that tournament.") }
      end
    end
  end
end
