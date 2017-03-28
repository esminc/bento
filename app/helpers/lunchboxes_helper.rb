module LunchboxesHelper
  def price_tag(lunchbox)
    "#{lunchbox.name} (#{lunchbox.price}円)"
  end
end
