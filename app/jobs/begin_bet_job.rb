class BeginBetJob < ApplicationJob
  queue_as :default

  def perform(bet)
    @portfolios = bet.portfolios

    if bet.in_progress?
      bet.finish!
      @portfolios.each do |portfolio|
        service = Bets::Valuate.new portfolio: portfolio
        service2 = Portfolios::CalculateReturn.new portfolio: portfolio
        if service.call
          portfolio.currentvalue = service.value_array
          portfolio.return = service2.call.value
          portfolio.save
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
