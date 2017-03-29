class AddBetReferencesToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_reference :portfolios, :bet, foreign_key: true, index:true
  end
end
