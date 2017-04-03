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

      portfolio.startvalue.each do |x|
        @start_a << x
      end
      portfolio.currentvalue.each do |x|
        @end_a << x
      end

      @value_array = []

      @end_a.each_with_index  do |x,index|
        @value_array << x / @start_a[index]
      end


      @value = 1.0

      @value_array.each do |x|
       @value = @value * x
      end
    end
  end
end
