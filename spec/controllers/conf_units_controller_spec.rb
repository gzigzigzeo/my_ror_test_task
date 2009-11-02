require 'spec_helper'

describe ConfUnitsController do  
  before(:each) do    
    @conf_unit = ConfUnit.make
    @conf_units = [@conf_unit]
    @invalid_conf_unit = ConfUnit.make_unsaved(:name => '')
    
    # В каждом экшне запрашивается список КУ (на индексе - все КУ, на остальных - возможные родители)
    mock(ConfUnit).find(:all) { @conf_units }    
  end
  
  describe :get => :index do
    should_respond_with(:success)
    it { should assign_to(:conf_units, :with => @conf_units) }    
  end
  
  describe :get => :new do  
    should_respond_with(:success)
    should_assign_to(:conf_unit)
  end
  
  describe :get => :new, :conf_unit => { 'name' => 'mock' } do
    before do
      mock(ConfUnit).new({'name' => 'mock'}) { @conf_unit }
    end
    
    should_respond_with(:success)
    should_assign_to(:conf_unit)    
    
    it "should assign conf_unit from params" do
      run_action!
      assigns[:conf_unit].name.should == @conf_unit.name
    end
  end
  
  describe :post => :create, :conf_unit => { 'name' => 'mock' } do
    before do
      mock(ConfUnit).new({'name' => 'mock'}) { @conf_unit }
    end
    
    should_redirect_to { conf_units_path }
  end
  
  describe :post => :create, :conf_unit => { 'name' => 'mock' } do
    before do
      mock(ConfUnit).new({'name' => 'mock'}) { @invalid_conf_unit }
    end
    
    should_render_template('new')
    
    it "should assign invalid conf_unit" do
      run_action!
      assigns[:conf_unit].should be_invalid
    end
  end  
  
  describe :get => :edit, :id => 1 do
    before do
      mock(ConfUnit).find('1') { @conf_unit }
    end
    
    should_respond_with(:success)
    should_assign_to(:conf_unit)
  end  
  
  describe :put => :update, :id => 1 do
    before do
      mock(ConfUnit).find('1') { @conf_unit }      
    end
    
    should_redirect_to { conf_units_path }
  end  

  describe :put => :update, :id => '1', :conf_unit => { 'name' => '' } do
    before do
      mock(ConfUnit).find('1') { @conf_unit }      
    end
    
    should_render_template('edit')
    it "should display invalid conf_unit" do
      run_action!
      assigns[:conf_unit].should be_invalid
    end
  end  
  
  describe "drag and drop" do        
    it "should have valid RJS" do
      # В модели nested_set'а вызывается куча всевозможных файндов, апдейтов и так далее.
      # Так что, здесь проще отказаться от моков.      
      RR.reset
      ConfUnit.make(:id => 100)
      ConfUnit.make(:id => 200)
      
      xhr :post, :drop, :reorder => 'false', :source => 'source_conf_unit_200', :target => 'target_conf_unit_100'
      
      should respond_with(:success)
    end    
  end
end
