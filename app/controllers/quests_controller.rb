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
    @quest = Quest.find(params[:id])
    if @quest.users.exists?(@current_user.id)
      gon.track = true
      locations = @quest.locations
      gon.remaining_locations = []
      gon.completed_locations = []
      locations.each do |loc|
        if loc.users.exists?(@current_user.id)
          gon.completed_locations << loc
        else
          gon.remaining_locations << loc
        end
      end
      @remaining_locations = gon.remaining_locations
      @completed_locations = gon.completed_locations
    else
      gon.track = false
      flash[:danger] = "You are not a member of this quest! Please contact the quest owner for an invite."
      redirect_to root_path
    end
  end

  def complete_location
    User.find(@current_user.id).locations << Location.find(params[:location_id])
  end

  def create
    # render :json => params
    quest_parameters = params[:quest]
    locations = JSON.parse quest_parameters[:locations]
    heroes = JSON.parse quest_parameters[:heroes]
  	quest = Quest.create(:name => quest_parameters['name'], :owner_id=>@current_user.id, :start_date=>quest_parameters['start'], :end_date=>quest_params['end'])
  	locations.each do |location|
      quest.locations.create name: location['name'], clue: location['clue'], lat: location['lat'], lng: location['lng'];
    end
    heroes.each do |hero|
      user = User.find_by email: hero
      if user
        user.quests << quest
      end
    end
    redirect_to root_path
  end

  def new
  end

  private

  def quest_params
  	params.require(:quest).permit(:name, :owner_id, :start, :end, :locations, :heroes)
  end
end
