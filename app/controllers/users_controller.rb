class UsersController < ApplicationController

	before_action :is_authenticated?, only: [:show]

  def create
  	# render :json => params
  	User.create signup_params

  	user = User.authenticate signup_params['email'], signup_params['password']
  	if user 
  		session[:user_id] = user.id
  		flash[:success] = "#{user.email} logged in successfully"
  		redirect_to user_path(user)
  	else
  		flash[:danger] = "Authentication failed"
  		redirect_to root_path
  	end
  end

  def new
  	User.new
  end

  def show
  	@current_user ||= User.find_by_id(session[:user_id])
  	@quests = Quest.where(owner_id: @current_user.id )
  	puts "******"
  	puts @quests
  	puts "******"
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def delete
  end

  private

  def signup_params
  	params.require(:users).permit(:email, :name, :password, :phone)
  end
end
