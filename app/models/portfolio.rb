class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :selected_tickers, through: :portfolio_tickers, source: :ticker
end
