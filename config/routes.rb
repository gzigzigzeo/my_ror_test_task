ActionController::Routing::Routes.draw do |map|
  map.resources :conf_units, :collection => { :drop => :post }
  map.resources :services

  map.root :controller => :conf_units
end
