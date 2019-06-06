class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :missions, dependent: :destroy

  validates :num_rooms, presence: true, numericality: { only_integer: true }

  validate :greater_than_zero?

  private

  def greater_than_zero?
    if self.num_rooms < 1
      self.errors.add(:num_rooms, "Listing must have at least one room.")
    end
  end
end
