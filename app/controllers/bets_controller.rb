class BetsController < ApplicationController
  before_action :authenticate_user!

  def update
    @bet = Bet.find params[:id]
    @charity = params[:bet][:charity]
    @portfolios = Portfolio.where(bet_id: @bet)
    if @bet.update(charity:@charity)
      redirect_to bet_path(@portfolios.first, bet_id: @bet), notice: 'Bet Updated'
    else
      redirect_to bet_path(@portfolios.first, bet_id: @bet), alert: 'Bet Not Updated'
    end
  end

  def index
    # All Bets
    if params[:user]
      @user = User.find params[:user]
      @portfolios = @user.portfolios.where("bet_id IS NOT NULL")
      @bets = Array.new
      @portfolios.each do |x|
        @bets << Bet.find(x.bet_id)
      end
    else
      @bets = Bet.all.posted.latest_first
      @bets += Bet.all.taken.latest_first
    end
    # TODO and state open add scope last first
  end
  # TODO Check for user time zone and display it in the form directly instead of storing it in db
  # TODO SEE ONLY MY BETS
  # TODO Close Bets

  def new
      @portfolio = Portfolio.find(params[:format])

      if @portfolio.in_bet?
        redirect_to portfolio_path(@portfolio.id)
        flash[:alert] = 'Bet already placed for this portfolio'
      else
# NOT DRY
       @ticker_array= []

       @portfolio.tickers.each do |x|
         @ticker_array << x.ticker
       end

       @name_array= []

       @portfolio.tickers.each do |x|
         @name_array << x.name
       end
  #
        @bet = Bet.new

        get_user_time_zone

        @defaultstartdate = @timezone.utc_to_local(Time.current) + 2.minutes
        @defaultenddate = @timezone.utc_to_local(Time.current) + 3.minutes

      end

  end

# TODO Add state Machine

  def create
    # binding.pry

    # Path when the bet is open
    if params[:bet_id]
      @portfolio = Portfolio.find(params[:portfolio_id])
      if @portfolio.in_bet?
        redirect_back(fallback_location: portfolio_path(@portfolio.id))
        flash[:alert] = 'Bet already placed with current portfolio'
      else
        @bet = Bet.find params[:bet_id]
        @portfolio.bet_id = @bet.id
        @portfolio.save
        @portfolio.to_bet!
        puts @portfolio.in_bet?
        flash[:notice] = 'Bet closed successfully'
        @bet.close!
        redirect_to bet_path(@portfolio, bet_id: @bet)
      end
    else
      @portfolio = Portfolio.find(bet_params[:portfolio])


      if @portfolio.in_bet?
        redirect_to portfolio_path(@portfolio.id)
        flash[:alert] = 'Bet already placed for this portfolio'
      else
        if params[:challenge]
          puts "challenge on"
        end
        @bet = Bet.new(bet_params)
        # portfolio_params["startdate(1i)"].to_i, portfolio_params["startdate(2i)"].to_i, portfolio_params["startdate(3i)"].to_i
        startdate = DateTime.new bet_params["startdate(1i)"].to_i,
                              bet_params["startdate(2i)"].to_i,
                              bet_params["startdate(3i)"].to_i,
                              bet_params["startdate(4i)"].to_i,
                              bet_params["startdate(5i)"].to_i

        enddate = DateTime.new bet_params["enddate(1i)"].to_i,
                              bet_params["enddate(2i)"].to_i,
                              bet_params["enddate(3i)"].to_i,
                              bet_params["enddate(4i)"].to_i,
                              bet_params["enddate(5i)"].to_i



        get_user_time_zone

        @bet.startdate = @timezone.local_to_utc(startdate)

        @bet.enddate = @timezone.local_to_utc(enddate)


        if @bet.save
          BeginBetJob.set(wait_until: @bet.startdate).perform_later @bet
          BeginBetJob.set(wait_until: @bet.enddate).perform_later @bet
          @portfolio.bet_id = @bet.id
          @portfolio.save
          @portfolio.to_bet!
          puts @portfolio.in_bet?
          flash[:notice] = 'Bet created successfully'
          redirect_to bets_path
        end
      end
    end
  end

  def show
    if params[:bet_id]
      @bet_id = params[:bet_id]
      @bet = Bet.find params[:bet_id]
      @closeportfolio = Portfolio.find params[:id]
      @portfolios = Portfolio.where(bet_id: @bet_id)
    else
    # link_to x.id, bet_path(x.id)
      @bet_id = params[:id]
      @portfolios = Portfolio.where(bet_id: @bet_id)
    end
  end

  private

  def bet_params
    params.require(:bet).permit([:startdate, :enddate, :portfolio, :amount])
  end

  def get_user_time_zone
    @timezone = Timezone[current_user.timezone]
  end

end
