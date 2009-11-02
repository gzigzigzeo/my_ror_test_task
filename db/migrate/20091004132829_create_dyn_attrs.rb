class CreateDynAttrs < ActiveRecord::Migration
  def self.up
    create_table :dyn_attrs do |t|
      t.references :conf_unit
      t.string     :name
      t.string     :value

      t.timestamps
    end
  end

  def self.down
    drop_table :dyn_attrs
  end
end
