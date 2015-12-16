class PhotosController < ApplicationController
  
    before_filter :authenticate_user!

  def new
    @photo = Photo.new
  end

  def index
    @photos = Photo.paginate(page: params[:page])
  end

  def destroy
      Photo.find(params[:id]).destroy
      flash[:success] = "Photo deleted"
      redirect_to admin_photos_path
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

  def edit
    @photo = Photo.find params[:id]
  end

  def update
  @photo = Photo.find params[:id]
  if @photo.update_attributes(photo_params)
    redirect_to admin_photos_path
  else
    render :edit
    end
  end

  private
      def photo_params
          params.require(:photo).permit(:caption, :file, :album_id)
      end
  end