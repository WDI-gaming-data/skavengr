class QuestsController < ApplicationController

	before_action :is_authenticated?

  def index
  end

  def edit
  end

  # Show route for players. Should only pass locations to the view if the player
  # hasn't already completed them. The front-end JS can then track if the user gets
  # close enough to complete them.
  def show
    quest = Quest.find(params[:id])
    if quest.users.exists?(@current_user.id)
      gon.track = true
      locations = quest.locations
      gon.remaining_locations = []
      locations.each do |loc|
        if loc.users.exists?(@current_user.id)
          break
        else
          gon.remaining_locations << loc
        end
      end
    else
      flash[:danger] = "You are not a member of this quest! Please contact the quest owner for an invite."
      redirect_to root_path
    end
  end

  def complete_location
    User.find(@current_user.id).locations << Location.find(params[:location_id])
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
