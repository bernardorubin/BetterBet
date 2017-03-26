class RemovePortfolioIdColumnFromUserPortfolio < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_portfolios, :portfolio_id
  end
end
