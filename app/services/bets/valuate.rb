require 'descriptive_statistics'
module Bets
  class Valuate
    include Virtus.model
    attribute :portfolio, Hash
    attribute :value_array, Array

    def call
      do_everything
    end

    def do_everything
      yahoo_client = YahooFinance::Client.new

      @ticker_array= []

      portfolio.tickers.each do |x|
        @ticker_array << x.ticker
      end

      @value_array = []

      @data = yahoo_client.quotes(@ticker_array, [:symbol, :last_trade_price, :previous_close, :ask, :bid])

      @data.each do |x|
        @value_array << x.last_trade_price.to_f
      end



      # @super_array = []

      # @ticker_array.each do |ticker|
      #   @super_array << StockQuote::Stock.quote("#{ticker}",nil , nil, ['last_trade_price_only'])
      # end


      # @super_array.each do |x|
      #   @value_array << x.last_trade_price_only
      # end

    end
  end
end
