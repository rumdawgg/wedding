class AlbumsController < ApplicationController
	before_filter :authenticate_user!, except: [:show]
  	
  	def new
    	@album = Album.new
  	end

	def edit
		@album = Album.find(params[:id])
	end
	
	def create
		@album = Album.new(album_params)
		if @album.save
		  flash[:success] = "The album was created!"
		  redirect_to photos_path
		else
		  render 'new'
		end
	end
    
    def show
     @album = Album.find(params[:id])
  	 @photos = @album.photos
    end

  	private
      	def album_params
        	params.require(:album).permit(:name, :description)
      	end

end
