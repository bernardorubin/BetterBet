class BetsController < ApplicationController

  def index

  end

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

  def create

  end

end
