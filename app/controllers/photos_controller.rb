class PhotosController < ApplicationController
  
  def new
    @photo = Photo.new
  end

  def view
    @photos = Photo.all
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = "The photo was added!"
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find params[:id]
  end

  def edit
    @photo = Photo.find params[:id]
  end

  def update
  @photo = Photo.find params[:id]

  if @photo.update_attributes(photo_params)
    redirect_to photos_path
  else
    render :edit
    end
  end

  private
      def photo_params
          params.require(:photo).permit(:caption, :file)
      end
  end