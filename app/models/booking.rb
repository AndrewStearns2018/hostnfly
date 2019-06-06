class Booking < ApplicationRecord
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :start_before_end?

  private

  def start_before_end?
    if self.start_date >= self.end_date
      self.errors.add(:start_date, "Start date must before end_date.")
    end
  end
end
