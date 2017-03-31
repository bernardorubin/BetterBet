class AddAasmStateToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :aasm_state, :string
  end
end
