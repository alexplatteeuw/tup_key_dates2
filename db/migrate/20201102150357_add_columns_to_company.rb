class AddColumnsToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :merging, :boolean, default: false
    add_column :companies, :absorbed, :boolean, default: false
  end
end
