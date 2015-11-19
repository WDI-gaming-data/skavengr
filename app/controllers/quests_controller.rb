class QuestsController < ApplicationController
  def index
  end

  def edit
  end

  def show
  end

  def create
  end

  def new
  end

  private

  def signup_params
  	params.require(:quests).permit(:email, :name, :password, :phone)
  end
end
