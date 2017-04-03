class AddWinnerToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :winner, :boolean, default: false
  end
end
