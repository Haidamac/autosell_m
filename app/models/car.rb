class Car < ApplicationRecord

  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :main, resize_to_limit: [800, 600]
  end

  enum status: %i[pending rejected approved]

  scope :filter_by_status, ->(status) { where(status:) }

  validates :brand, :car_model, :body, :mileage, :color, :fuel, :year, :volume, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end