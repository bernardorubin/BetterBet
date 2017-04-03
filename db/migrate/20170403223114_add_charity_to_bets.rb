class AddCharityToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :charity, :string
  end
end
