class BeginBetJob < ApplicationJob
  queue_as :default

  def perform(bet)
    if bet.taken?
      bet.begin!
    else
      bet.cancel!
    end
  end
end
