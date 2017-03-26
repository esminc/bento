module ApplicationHelper
  def bootstrap_alert_class(type)
    {alert:  'alert-danger',
     notice: 'alert-info'}.fetch(type.to_sym, '')
  end
end
