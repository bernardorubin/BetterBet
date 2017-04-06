class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    yahoo_client = YahooFinance::Client.new
    @data = yahoo_client.quotes(["GOOGL","AAPL","AMZN","MSFT","BRK-A"],[:symbol, :last_trade_price, :previous_close, :ask, :bid])
    puts @data
    # @data.each do |x|
    #   puts x.after_hours_change_realtime
    # end
    # @data2 = yahoo_client.historical_quotes("AAPL")
    # @data3 = []
    # @data2.each do |x|
    #   @data3 << x.to_h
    # end
  end
end
