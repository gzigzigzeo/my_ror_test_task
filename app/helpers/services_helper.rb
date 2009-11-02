module ServicesHelper
  def conf_unit_check_box(conf_unit)
    parents = conf_unit.ancestors.map { |a| "_parent_#{a.id}" }.join(" ")
    disabled = conf_unit.ancestors.find { |a| @service.conf_unit_ids.include?(a.id) }

    check_box_tag "service[conf_unit_ids][]", 
      conf_unit.id, 
      @service.conf_unit_ids.include?(conf_unit.id), 
      :class => "checks _tree #{parents}",
      :rel => conf_unit.id,
      :disabled => disabled,
      :checked => disabled
  end
end
