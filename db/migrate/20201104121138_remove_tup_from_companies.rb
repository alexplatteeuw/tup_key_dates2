class RemoveTupFromCompanies < ActiveRecord::Migration[6.0]
  def change
    remove_reference :companies, :tup, foreign_key: true
  end
end
