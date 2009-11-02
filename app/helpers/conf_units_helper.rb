module ConfUnitsHelper
  def conf_unit_option_tree(conf_units, selected)    
    selected_id = selected.nil? ? nil : selected.id
    html = '<option/>'
    ConfUnit.each_with_level(conf_units) do |conf_unit, level|
      html += content_tag(:option, conf_unit.name, :value => conf_unit.id, :class => "level_#{level}", :selected => selected_id == conf_unit.id ? true : nil)
    end
    html
  end

  def conf_unit_drag_helper(conf_unit)
    conf_unit.name
  end 
  
  def init_dyn_clone
    tpl = fields_for "conf_unit[dyn_attrs_attributes]", :index => "%index%" do |f|
      render :partial => "dyn_attr", :object => f
    end
    javascript_tag do
      %{
        $(document).ready(function() {
          DynAttr.initialize('#{escape_javascript(tpl)}', #{@conf_unit.dyn_attrs.length-1});
        });
      }
    end
  end
end
