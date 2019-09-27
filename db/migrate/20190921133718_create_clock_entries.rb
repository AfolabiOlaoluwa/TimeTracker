class CreateClockEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :clock_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :purpose
      t.datetime :time_in
      t.datetime :time_out

      t.timestamps
    end
    add_index :clock_entries, :purpose
    add_index :clock_entries, :time_in
    add_index :clock_entries, :time_out
  end
end
