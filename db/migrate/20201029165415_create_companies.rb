class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :siren
      t.string :headquarters
      t.string :legal_form
      t.integer :share_capital
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
