class BetsController < ApplicationController

  def index
    # All Bets
    @bets = Bet.all.latest_first
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

        @defaultstartdate = @timezone.utc_to_local(Time.current) + 2.hours
        @defaultenddate = @timezone.utc_to_local(Time.current) + 1.week
      end
  end

# TODO Add state Machine

  def create
    # binding.pry
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

    @portfolio = Portfolio.find(bet_params[:portfolio])

    if @bet.save
      @portfolio.bet_id = @bet.id
      @portfolio.save
      @portfolio.to_bet!
      puts @portfolio.in_bet?
      flash[:notice] = 'Bet created successfully'
      redirect_to bets_path
    end
  end

  def show
    # @portfolios = []

    # link_to x.id, bet_path(x.id)
    @bet_id = params[:id]
    @portfolios = Portfolio.where(bet_id: @bet_id)
    puts @portfolios
  end

  private

  def bet_params
    params.require(:bet).permit([:startdate, :enddate, :portfolio, :amount])
  end

  def get_user_time_zone
    @timezone = Timezone[current_user.timezone]
  end

end
