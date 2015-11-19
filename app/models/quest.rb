class Quest < ActiveRecord::Base
	validates :name,
	presence: true

	validates :owner_id,
	presence: true

	validates :start_date,
	presence: true

	validates :end_date, 
	presence: true



	has_and_belongs_to_many :users
end
