require 'spec_helper'

describe ConfUnit do
  it { should validate_presence_of :name }
    
  it { should have_and_belong_to_many :services }  
  it { should have_many :dyn_attrs }  
  
  it { should accept_nested_attributes_for :dyn_attrs, :accept => DynAttr.make,
                                                       :reject => DynAttr.make_unsaved(:name => ''),
                                                       :allow_destroy => true }

  it { should have_default_scope :order => ConfUnit.quoted_left_column_name }
end
