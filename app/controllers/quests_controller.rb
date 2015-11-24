class QuestsController < ApplicationController
  
	before_action :is_authenticated?
  before_action :set_time_zone

  def index

    @owner_quests = Quest.where(owner_id: @current_user.id )
    @player_quests = @current_user.quests

    @quest_creators = []
    @player_quests.each do |q|
      u = User.find_by(id: q.owner_id)
      puts "------*********"
      puts u.name
      puts "------*********"

      @quest_creators.push(u.name)
    end
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    # render :json => params
    quest = Quest.find params[:id]
    quest.update(name: params[:quest]['name'],start_date: params[:quest]['start'], end_date: params[:quest]['end'] )
    flash[:success] = "Quest edited!"
    redirect_to edit_quest_path(quest)
  end

  def add_location
    # render :json => params
    quest = Quest.find params[:id]
    quest.locations.create name: params[:location]['name'], clue: params[:location]['clue'], lat: params[:location]['lat'], lng: params[:location]['lng']
    redirect_to edit_quest_path(quest)
  end

  def remove_location
    # render :json => params
    quest = Quest.find params[:id]
    location = Location.find(params[:location])
    # render:json => location
    quest.locations.delete(location)
    location.destroy
    redirect_to edit_quest_path(quest)
  end

  def add_user
    # render :json => params
    quest = Quest.find(params[:id])
    user = User.find_by(email: params[:user]['email'])
    # render :json => user
    if user
      quest.users << user
      redirect_to edit_quest_path(quest)
    else
      flash[:warning] =  'invalid user'
      redirect_to edit_quest_path(quest)
    end
  end

  def remove_user
    # render :json => params
    quest = Quest.find(params[:id])
    user = User.find(params[:user])
    # render :json => user
    quest.users.delete(user)
    redirect_to edit_quest_path(quest)
  end

  # Show route for players. Should only pass locations to the view if the player
  # hasn't already completed them. The front-end JS can then track if the user gets
  # close enough to complete them.
  def show
    @quest = Quest.find(params[:id])
    quest_objectives = @quest.locations
    completed_objectives = []
    quest_objectives.each do |obj|
      if @current_user.locations.exists?(obj)
        completed_objectives << obj
      end
    end
    if completed_objectives.length == quest_objectives.length
      unless @quest.winner_id
        @quest.update(winner_id: @current_user.id)
      end
      redirect_to "/quests/" + @quest.id.to_s + "/complete"
    end

    if(@quest.owner_id == @current_user.id)
      redirect_to edit_quest_path(@quest)
    elsif @quest.start_date > DateTime.current
      flash[:warning] = "Quest has not yet begun!"
      redirect_to user_path(@current_user)
    elsif @quest.end_date < DateTime.current
      flash[:warning] = "Quest has ended. Womp womp"
      redirect_to user_path(@current_user)
    elsif @quest.users.exists?(@current_user.id)
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
      redirect_to quests_path
    end
  end

  def complete_location
    location = Location.find(params[:location_id])
    quest = Quest.find(location.quest_id)
    if !location.nil?
      joinObj = LocationsUsers.find_or_create_by(:user => @current_user, :location => location)
      quest_objectives = quest.locations
      completed_objectives = []
      quest_objectives.each do |obj|
        if @current_user.locations.exists?(obj)
          completed_objectives << obj
        end
      end
      if completed_objectives.length == quest_objectives.length
        unless quest.winner_id
          quest.update(winner_id: @current_user.id)
        end
        puts '***************'
        puts 'in the completion if statement'
        puts '***************'
        # redirect_to quests_location_path id: location.quest_id
        redirect_to "/quests/" + quest.id.to_s + "/complete"
      end
    end
  end

  def complete
    @quest = Quest.find(params[:id])
    @players = @quest.users
    # render :json => @players[0].locations.where(quest_id: @quest.id)
    @player_json = []
    @players.each_with_index do |player, i|
      @player_json[i] = @players[i].as_json
      @player_json[i][:finished] = @quest.created_at
      completed_objectives = player.locations.where(quest_id: @quest.id)
      if completed_objectives.length == @quest.locations.length
        completions = []
        completed_objectives.each do |item|
          if(LocationsUsers.exists?(location_id: item.id))
            completions << item
          end
        end
        for c in completions do
          if(c.created_at > @player_json[i][:finished])
            @player_json[i][:finished] = c.created_at
          end
        end
      end
    end
    # render :json => @player_json
  end

  def create
    # render :json => params
    quest_parameters = params[:quest]
    locations = JSON.parse quest_parameters[:locations]
    heroes = JSON.parse quest_parameters[:heroes]
  	quest = Quest.create(:name => quest_parameters['name'], :owner_id=>@current_user.id, :start_date=>quest_parameters['start'], :end_date=>quest_params['end'])
    if quest.save
    	locations.each do |location|
        quest.locations.create name: location['name'], clue: location['clue'], lat: location['lat'], lng: location['lng'];
      end
      heroes.each do |hero|
        user = User.find_by email: hero
        if user
          user.quests << quest
        end
      end
      redirect_to user_path(@current_user)
    else
      flash[:danger] = "Quest creation failed. please try again"
      redirect_to new_quest_path
    end
  end

  def new
  end

  def destroy
    # render :json => params
    quest = Quest.find params[:id]
    if quest.owner_id = @current_user.id
      quest.locations.each do |location|
        quest.locations.find(location.id).destroy
      end
      quest.destroy
      redirect_to user_path(@current_user)
    end
  end

  private

  def quest_params
  	params.require(:quest).permit(:name, :owner_id, :start, :end, :locations, :heroes)
  end
end
