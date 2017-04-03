class AddReturnToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :return, :float
  end
end
