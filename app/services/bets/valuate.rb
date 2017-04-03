require 'descriptive_statistics'
module Bets
  class Valuate
    include Virtus.model
    attribute :portfolio, Hash
    attribute :value, Float
    attribute :super_array, Array


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
        @super_array << StockQuote::Stock.quote("#{ticker}", nil, nil, ['Symbol', 'last_trade_realtime_with_time', 'last_trade_price_only'])
      end

      @super_array
      @value = 100.52
    end
  end
end
