class Quest < ActiveRecord::Base
	validates :name,
	presence: true

	validates :owner_id,
	presence: true

	validates :start_date,
	presence: true,
	# using validates_timeliness gem
	:timeliness => {:on_or_after => lambda { Date.current }, :type => :datetime}

	validates :end_date, 
	presence: true,
	# using validates_timeliness gem
	:timeliness => {:on_or_after => :start_date, :type => :datetime}



	has_and_belongs_to_many :users
end
