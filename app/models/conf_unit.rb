class ConfUnit < ActiveRecord::Base
  acts_as_nested_set

  has_and_belongs_to_many :services
  has_many :dyn_attrs

  validates_presence_of :name

  default_scope :order => quoted_left_column_name
  
  accepts_nested_attributes_for :dyn_attrs, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? }

  # Истина, если активность КУ изменилась со времени последней проверки.
  def activity_changed?
    active_last_checked != active
  end

  # Активирует услугу и всех её детей.
  def activate!
    change_activity(true)
  end
  
  # Деактивирует услугу и всех её детей.
  def deactivate!
    change_activity(false)
  end

protected
  def change_activity(a)
    self_and_descendants.each do |u| 
      u.active = a
      u.active_last_checked = a
      u.save!
    end
  end

  class << self
    # Возвращает два массива: активировавшиеся КУ и упавшие КУ (только верхние уровни).
    def check_activity
      deactivated  = []
      activated = []

      units = tree(all) # Экономим запросы.
      each_recursively(units) do |u|
        if u.activity_changed?
          if u.active
            u.activate!; activated << u
          else
            u.deactivate!; deactivated << u
          end
          false
        else
          true
        end
      end
      [activated, deactivated]
    end
  end
end