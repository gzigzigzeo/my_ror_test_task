namespace :db do
  namespace :fixtures do
    desc "Calls rebuild! for ConfUnit"
    task :rebuild_conf_units => :environment do
      ConfUnit.rebuild!
    end
  end
end
