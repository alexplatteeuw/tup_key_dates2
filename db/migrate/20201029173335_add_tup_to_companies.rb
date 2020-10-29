class AddTupToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :tup, foreign_key: true
  end
end
