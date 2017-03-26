class LunchboxDecorator < Draper::Decorator
  delegate_all

  def price_tag
    "#{name} (#{price}円)"
  end
end
