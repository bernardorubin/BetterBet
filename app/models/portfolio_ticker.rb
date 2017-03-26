class PortfolioTicker < ApplicationRecord
  belongs_to :portfolio
  belongs_to :ticker
end
