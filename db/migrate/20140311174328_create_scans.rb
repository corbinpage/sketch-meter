class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :username
      t.integer :score

      t.timestamps
    end
  end
end
