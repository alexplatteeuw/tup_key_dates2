class CreateTups < ActiveRecord::Migration[6.0]
  def change
    create_table :tups do |t|
      t.date :legal_effect
      t.date :opposition_start
      t.date :potential_opposition_end
      t.date :opposition_end
      t.date :publication

      t.timestamps
    end
  end
end
