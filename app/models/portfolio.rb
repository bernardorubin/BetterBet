class Portfolio < ApplicationRecord
  belongs_to :user
  # has_many :portfolio_tickers, dependent: :destroy
  has_many :portfolio_tickers
  has_many :tickers, through: :portfolio_tickers

  validates_date :startdate, :before => lambda { Date.today }

  include AASM

  aasm whiny_transitions: false do
    state :not_public, initial: true
    state :in_bet

    event :tobet do
      transitions from: :private, to: :in_bet
    end
  end

end
