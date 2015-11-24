class UsersController < ApplicationController

	before_action :is_authenticated?, only: [:show]

  def create
  	User.create signup_params

    # Twilio welcome text
    number_to_send_to = signup_params['phone']
    twilio_phone_number = '9784671378'

  

    @@twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Thank you for signing up to Skavengr!"
    )

    # authentication
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
  	@owner_quests = Quest.where(owner_id: @current_user.id )
    @player_quests = @current_user.quests
  end

  def edit
    @current_user ||= User.find_by_id(session[:user_id])
    @user = User.find_by_id(session[:user_id])
  end

  def update
    u = User.find params[:id]
    u.update(name: params[:user]['name'], phone: params[:user]['phone'])
    redirect_to user_path(u)
  end

  def delete
  end

  private

  def signup_params
  	params.require(:users).permit(:email, :name, :password, :phone)
  end

end
