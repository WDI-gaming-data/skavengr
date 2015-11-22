class QuestsController < ApplicationController

	before_action :is_authenticated?

  def index
  end

  def edit
  end

  def show
  end

  def create
    # render :json => params
    quest_parameters = params[:quest]
    locations = JSON.parse quest_parameters[:locations]
    heroes = JSON.parse quest_parameters[:heroes]
  	quest = Quest.create(:name => "test", :owner_id=>1, :start_date=>quest_parameters['start'], :end_date=>quest_params['end'])
  	locations.each do |location|
      quest.locations.create name: location['name'], clue: location['clue'], lat: location['lat'], lng: location['lng'];
    end
    heroes.each do |hero|
      hero = User.find_by email: hero
      puts hero
    end
    redirect_to root_path
  end

  def new
  end

  private

  def quest_params
  	params.require(:quest).permit(:name, :owner_id, :start, :end)
  end
end
