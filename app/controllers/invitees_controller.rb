class InviteesController < ApplicationController

  def index
    @invitees = Invitee.all
  end

  def get_meal(meal)
    @meal = Meal.find(meal)
    return @meal.name
  end

  def show
    @invitee = Invitee.find(params[:id])
    @guests = @invitee.guests
    rescue ActiveRecord::RecordNotFound
  end

  def new
    @invitee = Invitee.new
    @invitee.guests.new # build ingredient attributes, nothing new here
  end

  def create
    @invitee = Invitee.new(invitee_params)
    if params[:add_guest]
      @guest = @invitee.guests.build
    elsif params[:remove_ingredient]
    else
      if @invitee.save
        flash[:notice] = "Registration Sucessful."
        redirect_to @invitee and return
      end
    end
    render :action => 'new'
  end

  helper_method :get_meal

  private
  def invitee_params
        params.require(:invitee).permit(:first_name,:last_name,guests_attributes:[:first_name,:last_name,:meal_id,:_destroy,:id])
  end

end
