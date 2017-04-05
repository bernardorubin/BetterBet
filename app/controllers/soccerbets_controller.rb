class SoccerbetsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @user = User.find(current_user)
    @soccerbet = Soccerbet.new
  end

  def create
    # render json:params[:soccerbet][:soccerteam_ids].last
    @teamid = params[:soccerbet][:soccerteam_ids].last
    @teamid = Soccerteam.find @teamid
    @soccerbet = Soccerbet.new
    if @soccerbet.save
      redirect_to soccerbet_path(@soccerbet, res: @res, team_id: @teamid)
    end
  end

  def show
    @soccerbet = Soccerbet.find params[:id]
    if @soccerbet.closed?
      @res = FootballData.fetch(:fixtures, "/", id: @soccerbet.fixture_id)
       if @res["fixture"]["result"]["goalsHomeTeam"] == nil && @res["fixture"]["result"]["goalsAwayTeam"] == nil
       elsif @res["fixture"]["result"]["goalsHomeTeam"] < @res["fixture"]["result"]["goalsAwayTeam"]
         @soccerbet.winner = @res["fixture"]["result"]["goalsHomeTeam"]
         @soccerbet.finish!
         @soccerbet.save
       else
         @soccerbet.winner = @res["fixture"]["result"]["goalsHomeTeam"]
         @soccerbet.finish!
         @soccerbet.save
       end
      render :openbet
    else
      @teamid = Soccerteam.find params[:team_id]
      @res = FootballData.fetch(:teams, :fixtures, id: @teamid.team_id, timeFrame: 'n10')
      get_user_time_zone
    end
  end

  def update
    @soccerbet = Soccerbet.find params[:id]
    if params[:user_id]
      @soccerbet.user_id2 = current_user.id

      if @soccerbet.save
        @soccerbet.close!
        flash[:notice] = 'Bet Closed Successfully'
        p = UserSoccerbet.new
        p.user_id = current_user.id
        p.soccerbet_id = @soccerbet.id
        p.save
        redirect_to soccerbet_path
      end
    else
      @soccerbet.team_id1 = params[:soccerbet][:team]
      @soccerbet.fixture_id = params[:soccerbet][:fixture_id]

      @soccerbet.save

      @res = FootballData.fetch(:fixtures, "/", id: @soccerbet.fixture_id)

      if @soccerbet.team_id1 == @res["fixture"]["homeTeamId"]
        @soccerbet.team_id2 = @res["fixture"]["awayTeamId"]
      else
        @soccerbet.team_id2 = @res["fixture"]["homeTeamId"]
      end

      @soccerbet.fixture_date = params[:soccerbet][:fixture_date].to_datetime.utc
      @soccerbet.amount = params[:soccerbet][:amount]
      @soccerbet.user_id1 = current_user.id
      if @soccerbet.save
        @soccerbet.post!
        flash[:notice] = 'Bet posted successfully'
        p = UserSoccerbet.new
        p.user_id = current_user.id
        p.soccerbet_id = @soccerbet.id
        p.save
        redirect_to bets_path
      end
    end
  end

  private

  def get_user_time_zone
    @timezone = Timezone[current_user.timezone]
  end

end
