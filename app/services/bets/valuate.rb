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
      @ticker_array= []

      portfolio.tickers.each do |x|
        @ticker_array << x.ticker
      end

      @super_array = []

      @ticker_array.each do |ticker|
        @super_array << StockQuote::Stock.quote("#{ticker}",nil , nil, ['last_trade_price_only'])
      end

      @value_array = []

      @super_array.each do |x|
        @value_array << x.last_trade_price_only
      end

      # @value_array = ['a','b','c']

      # @value_array = [ 100.2, 100.3, 100.4]

    end
  end
end
