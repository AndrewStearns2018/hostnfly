json.array! @bookings do |booking|
  json.extract! booking, :id, :start_date, :end_date
end
