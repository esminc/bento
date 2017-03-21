def next_weekday_of(date)
  next_date = date.tomorrow
  return next_date unless holiday?(next_date)

  next_weekday_of(next_date)
end

def holiday?(date)
  # NOTE: 土日、もしくは国で定められた祝日であれば、平日扱いにはしたくない。
  date.sunday? || date.saturday? || HolidayJp.holiday?(date)
end
