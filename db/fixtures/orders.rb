14.times do |i|
  Order.seed(:id,
    id: i + 1, date: Time.zone.today.since(i.days)
  )
end
