class CreateCompanyTups < ActiveRecord::Migration[6.0]
  def change
    create_table :company_tups do |t|
      t.references :company, null: false, foreign_key: true
      t.references :tup, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
