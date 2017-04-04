class AddAmountToSoccerbets < ActiveRecord::Migration[5.0]
  def change
    add_column :soccerbets, :amount, :integer
  end
end
