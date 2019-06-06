class Reservation < ApplicationRecord
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_before_end?
  validate :in_booking_timeframe?
  validate :no_reservation_conflict?

  private

  def start_before_end?
    if self.start_date >= self.end_date
      self.errors.add(:start_date, "Start date must before end_date.")
    end
  end

  def in_booking_timeframe?
    within_timeframe = false
    self.listing.bookings.each do |booking|
      if booking.start_date <= self.start_date && booking.end_date >= self.end_date
        within_timeframe = true
      end
    end
    if !within_timeframe
      self.errors.add(:start_date, "No reservation for unavailable apartment")
    end
    # unless self.listing.bookings.where("start_date <= ? AND end_date >= ?", "self.start_date", "self.end_date")
    #   self.errors.add(:start_date, "No reservation for unavailable apartment")
    # end
  end

  def no_reservation_conflict?
    reservation_conflict = false
    self.listing.reservations.each do |reservation|
      if self.start_date >= reservation.start_date && self.start_date <= reservation.end_date
        reservation_conflict = true
      elsif self.end_date >= reservation.start_date && self.end_date <= reservation.end_date
        reservation_conflict = true
      end
    end
    if reservation_conflict
      self.errors.add(:start_date, "There is another reservation for these dates.")
    end
    # binding.pry
    # if self.listing.reservations.where("start_date <= ? AND end_date >= ?",  "self.start_date", "self.start_date").count > 0
    #   self.errors.add(:start_date, "There is another reservation for these dates.")
    # end
    # if self.listing.reservations.where("start_date <= ? AND end_date >= ?", "self.end_date", "self.end_date").count > 0
    #   self.errors.add(:start_date, "There is another reservation for these dates.")
    # end
  end
end
