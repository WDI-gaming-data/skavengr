class Location < ActiveRecord::Base
  validates :name,
  presence: true

  validates :clue,
  presence: true

  validates :lat,
  presence: true,
  numericality: {
  	greater_than_or_equal_to: -90,
  	less_than_or_equal_to: 90
  }

  validates :lng,
  presence: true,
  numericality: {
  	greater_than_or_equal_to: -180,
  	less_than_or_equal_to: 180
  }

  belongs_to :quest
end
