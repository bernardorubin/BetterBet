class AddAasmStateToSoccerbets < ActiveRecord::Migration[5.0]
  def change
    add_column :soccerbets, :aasm_state, :string
  end
end
