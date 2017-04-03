class BeginBetJob < ApplicationJob
  queue_as :default

  def perform(bet)
    if bet.taken?
      bet.begin!
      @portfolios = bet.portfolios
      @portfolios.each do |portfolio|
        service = Bets::Valuate.new portfolio: portfolio
        if service.call
          # @service = service.super_array
          portfolio.startvalue = service.value_array
          portfolio.save
        end
      end
    else
      bet.cancel!
    end
  end
end
