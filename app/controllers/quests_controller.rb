class QuestsController < ApplicationController

	before_action :is_authenticated?
	before_action :current_user
  def index
  end

  def edit
  end

  def show
  end

  def create
  	Quest.create(:name => "testaquest", :owner_id=>1)
  	redirect_to new_quest_path
  end

  def new
  end

  private

  def quest_params
  	params.require(:quests).permit(:name, :owner_id, :start_date, :end_date)
  end
end
