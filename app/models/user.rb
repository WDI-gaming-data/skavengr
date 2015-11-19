class User < ActiveRecord::Base
	validates :email,
	presence: true,
	email: true,
	uniqueness: {case_sensitive: false}

	validates :password,
	presence: true,
	confirmation: true,
	length: {minimum: 8}

	validates :name,
	presence: true

	validates :phone,
	presence: true,
	length: {is: 10}

	has_secure_password

	has_and_belongs_to_many :quests

	def self.authenticate email, password
		User.find_by_email(email).try(:authenticate, password)
	end

end
