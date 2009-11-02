class Service < ActiveRecord::Base
  has_and_belongs_to_many :conf_units

  validates_presence_of :name
  
  named_scope :ordered, { :order => "name ASC" }
  named_scope :with_conf_units, { :include => :conf_units }  
end
