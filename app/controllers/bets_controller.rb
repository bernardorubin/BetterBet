class BetsController < ApplicationController

  def index
    # All Bets
    @bets = Bet.all.latest_first
    # TODO and state open add scope last first
  end


  # TODO SEE ONLY MY BETS
  # TODO Close Bets


  def new
    @portfolio = Portfolio.find(params[:format])

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
  end

# TODO Add state Machine

  def create
    @bet = Bet.new(bet_params)
    @portfolio = Portfolio.find(bet_params[:portfolio])
    if @bet.save
      @portfolio.bet_id = @bet.id
      @portfolio.save
      flash[:notice] = 'Bet created successfully'
      redirect_to bets_path
    end
  end

  def show
    # @portfolios = []
    @bet_id = params[:id]
    @portfolios = Portfolio.where(bet_id: @bet_id)
    puts @portfolios
  end

  private

  def bet_params
    params.require(:bet).permit([:startdate, :enddate, :portfolio])
  end
end
