class MainController < ApplicationController
	before_action :current_user
	def index
		puts "------"
		puts ENV["ACCOUNT_SID"]
		puts "------"
	end

	def mapstest
	end
end
