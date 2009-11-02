class ConfUnitsController < ApplicationController
  before_filter :get_conf_units, :except => [:index, :destroy, :drop]
    
  resource_controller
  
  create do
    wants.html { redirect_to conf_units_path }
    flash nil
  end
  
  update do
    wants.html { redirect_to conf_units_path }
    flash nil
  end
  
  destroy.flash nil  
  
  # Логика перетаскивания/сортировки. Частично это нужно будет вынести в модель.
  def drop
    source_id = params[:source].gsub('source_conf_unit_', '').to_i
    source = ConfUnit.find(source_id)
    
    if params[:reorder] == 'false'      
      if params[:target] == 'root'
        source.move_to_root
        source.move_to_right_of(ConfUnit.roots.last)        
      else      
        target_id = params[:target].gsub('target_conf_unit_', '').to_i
        target = ConfUnit.find(target_id)
        source.move_to_child_of(target)
      end
    else
      target_id = params[:target].gsub('target_conf_unit_', '').to_i
      target = ConfUnit.find(target_id)
      if source.parent_id == target.parent_id
        if source.lft > target.lft
          source.move_to_left_of(target)
        else
          source.move_to_right_of(target)
        end
      end
    end
    
    get_conf_units    
  end

protected
  def get_conf_units
    @conf_units = end_of_association_chain.all
  end  
end