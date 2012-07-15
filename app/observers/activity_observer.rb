class ActivityObserver < ActiveRecord::Observer
  observe "ActsAsActivity::Activity"

  def after_create activity
    #activity.owner.create_timeline_entry activity
  end

end