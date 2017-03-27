class Portfolio < ApplicationRecord
  belongs_to :user
  # has_many :portfolio_tickers, dependent: :destroy
  has_many :portfolio_tickers
  has_many :tickers, through: :portfolio_tickers

  validates_date :startdate, :before => lambda { Date.today }
end
