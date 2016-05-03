class MealsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @meals = Meal.all
  end

  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      flash[:notice] = "Registration Sucessful."
      redirect_to admin_meals_path and return
    end
      render :new
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update_attributes(meal_params)
      redirect_to admin_meals_path
    else
      render :edit
    end
  end

  def destroy
    Meal.find(params[:id]).destroy
    flash[:success] = "Meal deleted"
    redirect_to admin_meals_path
  end

  private
  def meal_params
    params.require(:meal).permit(:name)
  end
end
