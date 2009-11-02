class ServicesController < ApplicationController
  resource_controller
  
  before_filter :get_conf_units, :except => [:index, :destroy]
  
  create do
    wants.html { redirect_to services_path }
    flash nil
  end
  
  update do
    wants.html { redirect_to services_path }
    flash nil
  end
  
  destroy.flash nil
  
private
  # Если не передан ни один ID KE - их нужно сбрасывать.
  def object_params
    (super || {}).reverse_merge(:conf_unit_ids => [])
  end
  
  def collection
    @collection ||= end_of_association_chain.with_conf_units.ordered
  end

  def object
    @object ||= end_of_association_chain.with_conf_units.find(param)
  end
  
  def get_conf_units
    @conf_units = ConfUnit.cache(ConfUnit.all)
  end
end
