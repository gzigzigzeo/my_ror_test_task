namespace :conf_unit do
  desc "Notify user on failed tasks"
  task :notify => :environment do
    logger = Logger.new(STDOUT)

    activated, deactivated = ConfUnit.check_activity
    logger.info "ACTIVATED: #{activated.map { |u| u.id }.join(', ')}"
    logger.info "DEACTIVATED: #{deactivated.map { |u| u.id }.join(', ')}"
  end

  task :simulate_deactivation => :environment do
    logger = Logger.new(STDOUT)

    active_units = ConfUnit.all(:conditions => { :active => true })
    2.times do
      u = active_units[rand(active_units.length)]
      u.active = false
      u.save!
      logger.info "Marking #{u.id} as inactive"
    end
  end

  task :simulate_activation => :environment do
    logger = Logger.new(STDOUT)

    inactive_units = ConfUnit.all(:conditions => { :active => false })
    2.times do
      u = inactive_units[rand(inactive_units.length)]
      u.active = true
      u.save!
      logger.info "Marking #{u.id} as active"
    end
  end
end