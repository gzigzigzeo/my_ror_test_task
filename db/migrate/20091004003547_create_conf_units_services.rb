class CreateConfUnitsServices < ActiveRecord::Migration
  def self.up
    create_table :conf_units_services, :id => false do |t|
      t.references :conf_unit
      t.references :service
    end
  end

  def self.down
    drop_table :conf_units_services
  end
end
