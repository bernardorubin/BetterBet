require 'descriptive_statistics'
class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @portfolios = @user.portfolios
    else
      redirect_back fallback_location: root_path, alert: 'Back'
    end
  end

  def update
    @portfolio = Portfolio.find params[:id]
      if @portfolio.update(portfolio_params)
        flash[:notice] = 'Portfolio updated successfully'
        redirect_to portfolio_path
      end
  end

  def new
    @portfolio = Portfolio.new
  end

  def create

    date = Date.new portfolio_params["startdate(1i)"].to_i, portfolio_params["startdate(2i)"].to_i, portfolio_params["startdate(3i)"].to_i
    # render json:portfolio_params
    @portfolio  = Portfolio.new
    @portfolio.startdate = date
    @portfolio.user = current_user
    if @portfolio.save
      flash[:notice] = 'Portfolio created successfully'
      portfolio_params[:ticker_ids].each do |x|
        p = PortfolioTicker.new
        p.ticker_id = x
        # TODO fix below for many users
        p.portfolio_id = Portfolio.last.id
        p.save
      end
      redirect_to portfolio_path(@portfolio)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

# Add validations for seeds and everything
# Track the bet?
# Add cancan so noone can see other bets status maybe?
# add state machine
# TODO check in Portfolio show if th portfolio si in an active bet

  def show
    # graph portfolio performance
    # Set dates in request as 1 week etc, not by exact date
    # DATES HERE?????????????????????????????????????????
    @portfolio = Portfolio.find params[:id]
    service = Portfolios::CreateAnalysis.new portfolio: @portfolio

    if service.call
      @enddate = service.enddate
      @portfolio = service.portfolio
      @zip_fundamental = service.zip_fundamental
      @data1 = service.data1
      @data2 = service.data2
      @data3 = service.data3
      @zip_inter = service.zip_inter
      @zip_return = service.zip_return
      @zip_dollars = service.zip_dollars
      @zip_sortino = service.zip_sortino
      @sortino_graph = service.sortino_graph
      @portfolio_last = service.portfolio_last
      @minimum = service.minimum
      @maximum = service.maximum
      puts @service
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit([:startdate, { ticker_ids: [] }])
  end



end
