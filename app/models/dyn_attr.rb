class DynAttr < ActiveRecord::Base
  belongs_to :conf_unit
  validates_presence_of :name, :value
end
