module Observable
  extend ActiveSupport::Concern

  included do
    after_update :notify_observers, if: :saved_change_to_status?
  end

  def add_observer(observer)
    @observers ||= []
    @observers << observer
  end

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end
end
