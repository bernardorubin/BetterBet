require 'descriptive_statistics'
class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @portfolios = @user.portfolios.latest_first
      if params[:bet_id]
        @bet_id = params[:bet_id]
      end
    else
      redirect_back fallback_location: root_path, alert: 'Back'
    end
  end

  def update
    @portfolio = Portfolio.find params[:id]
      if @portfolio.in_bet?
        flash[:alert] = 'Can\'t update portfolio when it\'s in a bet'
        redirect_to portfolio_path
      else
        if @portfolio.update(portfolio_params)
          flash[:notice] = 'Portfolio updated successfully'
          redirect_to portfolio_path
        end
      end
  end

  def destroy
    @portfolio = Portfolio.find params[:id]
    if @portfolio.in_bet?
        redirect_to user_portfolios_path(current_user), alert: 'Can\'t delete once a bet is public'
    else
      if @portfolio.destroy
        redirect_to user_portfolios_path(current_user), alert: 'Portfolio Removed'
      else
        # redirect_to @vote.question, alert: 'Can\'t remove vote'
      end
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
      if @portfolio.tickers.present?
        redirect_to portfolio_path(@portfolio)
      else
        @portfolio.destroy
        redirect_to new_portfolio_path
        flash[:alert] = 'Portfolio deleted because it cannot be empty'
      end
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

# TODO check in Portfolio show if th portfolio si in an active bet
# Add validations for seeds and everything
# Track the bet?
# Add cancan so noone can see other bets status maybe?
# add state machine

  def show
    # graph portfolio performance
    # Set dates in request as 1 week etc, not by exact date
    # DATES HERE?????????????????????????????????????????
    @portfolio = Portfolio.find params[:id]
    if can? :manage, @portfolio
      service = Portfolios::CreateAnalysis.new portfolio: @portfolio
      if service.call
        @ticker_array= []
        @portfolio.tickers.each do |x|
          @ticker_array << x.name
        end
        @tickers= @ticker_array.join(", ")
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
        @feed = service.feed
      end
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit([:startdate, { ticker_ids: [] }])
  end



end
