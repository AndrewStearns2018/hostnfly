module MissionService
  class << self
    def first_checkin(params)
      checkin = Mission.new(
        mission_type: "first_checkin",
        date: params[:start_date],
        price: "#{10 * find_listing(params).num_rooms}",
        listing: find_listing(params)
        )
      return checkin.save
    end

    def last_checkout(params)
      checkout = Mission.new(
        mission_type: "last_checkout",
        date: params[:end_date],
        price: "#{5 * find_listing(params).num_rooms}",
        listing: find_listing(params)
        )
      return checkout.save
    end

    def find_first_checkin(params)
      booking = find_booking(params)
      listing = booking.listing
      checkin_mission = Mission.find_by(
      listing: listing,
      date: booking.start_date,
      mission_type: "first_checkin")
      return checkin_mission
    end

    def find_last_checkout(params)
      booking = find_booking(params)
      listing = booking.listing
      checkout_mission = Mission.find_by(
      listing: listing,
      date: booking.end_date,
      mission_type: "last_checkout")
      return checkout_mission
    end

    def find_listing(params)
      Listing.find(params[:listing_id])
    end

    def find_booking(params)
      Booking.find(params[:id])
    end
  end
end
