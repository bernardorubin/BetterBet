class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    # stock = StockQuote::Stock.quote("aapl",nil , nil, ['last_trade_price_only'])
    # puts 'CHUY'
    # puts stock.last_trade_price_only
  end
end
