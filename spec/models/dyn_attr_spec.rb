require 'spec_helper'

describe DynAttr do
  it { should validate_presence_of :name, :value }
  it { should belong_to :conf_unit }
end
