class AddAasmStateToBets < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :aasm_state, :string
  end
end
