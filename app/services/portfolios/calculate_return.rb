require 'descriptive_statistics'
module Portfolios
  class CalculateReturn
    include Virtus.model
    attribute :portfolio, Hash
    attribute :value, Float

    def call
      do_everything
    end

    def do_everything
      @start_a = []
      @end_a = []
      portfolio.each do |x|
        @start_a = x.startvalue
        @end_a = x.endvalue
      end

      @value_array = []
      @end_a.each_with_index  do |x,index|
        @value_array << x / @start_a[index]
      end

      @value = 0.0

      @value_array.each do |x|
       @value += x
      end
    end
  end
end
