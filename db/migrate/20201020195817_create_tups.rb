class CreateTups < ActiveRecord::Migration[6.0]
  def change
    create_table :tups do |t|
      t.date "publication", null: false
      t.date "opposition_start", null: false
      t.date "opposition_end", null: false
      t.date "legal_effect", null: false
      t.date "theoretical_opposition_end"
      t.string "publications"
      t.timestamps
    end
  end
end
