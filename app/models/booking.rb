class Booking < ApplicationRecord
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_before_end?
  validate :no_overlapping_bookings?
  validate :no_conflict_with_reservations?

  private

  def start_before_end?
    if self.start_date >= self.end_date
      self.errors.add(:start_date, "Start date must before end_date.")
    end
  end

  def no_overlapping_bookings?
    overlapping_bookings = false
    self.listing.bookings.each do |booking|
      if self.start_date >= booking.start_date && self.start_date <= booking.end_date
        overlapping_bookings = true
      elsif self.end_date >= booking.start_date && self.end_date <= booking.end_date
        overlapping_bookings = true
      end
    end
    if overlapping_bookings
      self.errors.add(:start_date, "There already is a booking for this date.")
    end
  end

  def no_conflict_with_reservations?
    can_update_dates = false
    self.listing.reservations.each do |reservation|
      if self.start_date >= reservation.start_date && self.start_date <= reservation.end_date
        self.errors.add(:start_date, "You cannot change booking when there is a reservation.")
      elsif self.end_date >= reservation.start_date && self.end_date <= reservation.end_date
        self.errors.add(:start_date, "You cannot change booking when there is a reservation.")
      end
    end
  end
end
