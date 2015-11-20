class SessionsController < ApplicationController
  def create
  	user = User.authenticate login_params['email'], login_params['password']
  	if user 
  		session[:user_id] = user.id
  		flash[:success] = "#{user.email} logged in successfully"
  		redirect_to user_path(user)
  	else
  		flash[:danger] = "Authentication failed"
  		redirect_to root_path
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end

  private

  def login_params
  	params.require(:user).permit(:email, :password)
  end

end
