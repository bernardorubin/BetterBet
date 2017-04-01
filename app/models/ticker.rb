class Ticker < ApplicationRecord
  # has_many :portfolio_tickers, dependent: :destroy
  # has_many :portfolios, through: :portfolio_tickers

  validates :name, uniqueness: true
end
