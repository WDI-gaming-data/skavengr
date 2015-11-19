class UsersController < ApplicationController
  def create
  # 	User.create signup_params
  # 	user = User.authenticate signup_params['email'], signup_params['password']
  # 	if user
  # 		session[:user_id] = user.id
		# flash[:success] = "#{user.email} logged in successfully"
		# redirect_to root_path
  # 	else
  # 		flash[:danger] = "User login failed"
		# redirect_to login_path
  # 	end
  end

  def new
  end

  def show
  end

  def delete
  end

  private

  def signup_params
  	params.require(:user).permit(:email, :name, :password, :phone)
  end
end
