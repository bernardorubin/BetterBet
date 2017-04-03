class BeginBetJob < ApplicationJob
  queue_as :default

  def perform(bet)
    @portfolios = bet.portfolios

    if bet.in_progress?
      bet.finish!
      @portfolios.each do |portfolio|
        service = Bets::Valuate.new portfolio: portfolio
        if service.call
          portfolio.currentvalue = service.value_array
          portfolio.save
        end
        service = Portfolios::CalculateReturn.new portfolio: portfolio
        if service.call
          portfolio.return = service.value
          portfolio.save
        end
      end
      @return_a = []
      @portfolios.each do |x|
        @return_a << x.return
      end

      @returnmax = @return_a.max

      @portfolios.each do |x|
        if x.return == @returnmax
          x.winner= true
          x.save
        end
      end     

    else
      if bet.taken?
        bet.begin!
        @portfolios.each do |portfolio|
          service = Bets::Valuate.new portfolio: portfolio
          if service.call
            portfolio.startvalue = service.value_array
            portfolio.save
          end
        end
      else
        bet.cancel!
      end
    end
  end
end
