class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @user = User.find(params[:user_id])
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @user = User.find(params[:user_id])
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @user = User.find(params[:user_id])
    @event = @user.events.create(event_params.merge(user: current_user))
    redirect_to user_events_path
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event.update(event_params.merge(user:current_user))
    redirect_to user_path(@event)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :link, :start_time)
    end
end
