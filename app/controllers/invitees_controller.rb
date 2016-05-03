class InviteesController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]

  def index
    @invitees = Invitee.all
  end

  def show
    @invitee = Invitee.find(params[:id])
    @guests = @invitee.guests
    rescue ActiveRecord::RecordNotFound
  end

  def new
    @invitee = Invitee.new
  end

  def create
    @invitee = Invitee.new(invitee_params)
    if @invitee.save
      flash[:notice] = "Registration Sucessful."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def invitee_params
    params.require(:invitee).permit(:first_name,:last_name,:meal_id,guests_attributes:[:first_name,:last_name,:meal_id,:_destroy,:id])
  end

end
