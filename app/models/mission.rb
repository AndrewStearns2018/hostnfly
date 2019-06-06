class Mission < ApplicationRecord
  belongs_to :listing

  validates :mission_type, presence: true
  validates :date, presence: true
  validates :price, presence: true
end
