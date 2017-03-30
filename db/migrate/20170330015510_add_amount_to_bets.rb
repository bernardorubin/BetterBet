class AddAmountToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :amount, :float
  end
end
