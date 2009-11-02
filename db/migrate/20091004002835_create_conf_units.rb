class CreateConfUnits < ActiveRecord::Migration
  def self.up
    create_table :conf_units do |t|
      t.string    :name,                :null => false
      t.boolean   :active,              :default => true
      t.boolean   :active_last_checked, :default => true

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end

  def self.down
    drop_table :conf_units
  end
end
