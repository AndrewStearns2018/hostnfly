class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :missions, dependent: :destroy

  validates :room_num, presence: true, numericality: { only_integer: true }

  validate :greater_than_zero?

  private

  def greater_than_zero?
    if self.room_num < 1
      self.errors.add(:room_num, "Listing must have at least one room.")
    end
  end
end
