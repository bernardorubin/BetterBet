class ChangeStartDatePortfolio < ActiveRecord::Migration[5.0]
  def change
    change_column :portfolios, :startdate, :date
  end
end
