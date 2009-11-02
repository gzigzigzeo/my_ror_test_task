module ApplicationHelper
  def icon(id, *args)
    options = args.extract_options!    
    image_tag("admin/#{id}.png", {:width => 16, :height => 16}.merge(options))
  end
  
  # Навигационная ссылка в любом меню.
  def nav_link(label, active, chosen = nil, url = nil)
    state = action_state(active, chosen)
    to_extract = active.is_a?(String) ? active : active.first
    controller, action = extract_controller_and_action(to_extract)

    url = url || url_for(:controller => controller, :action => action)

    content = case state
    when :inactive, :chosen
      link_to label, url
    when :active
      label
    end

    content_tag :li, content, :class => %w(active chosen).include?(state.to_s) ? "chosen" : ""
  end  
end
