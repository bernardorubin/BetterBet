class Portfolio < ApplicationRecord
  belongs_to :user
  # has_many :portfolio_tickers, dependent: :destroy
  has_many :portfolio_tickers, dependent: :destroy
  has_many :tickers, through: :portfolio_tickers

  # validates :tickers, presence: true
  validates_date :startdate, :before => lambda { Date.today }
  scope :latest_first, -> {order(created_at: :desc)}
  include AASM

  aasm whiny_transitions: false do
    state :not_public, initial: true
    state :in_bet

    event :to_bet do
      transitions from: :not_public, to: :in_bet
    end
  end

end
