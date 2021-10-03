class MoviesController < ApplicationController
    before_action :has_moviegoer_and_movie, :except => [:index, :show]

    def has_moviegoer_and_movie
        unless @current_user
          flash[:warning] = 'You must be logged in.'
          redirect_to movies_path
        end
    end

    def index
      @movies = Movie.all.sort_by { |name| name.title}
    end

    def show
        id = params[:id]
        begin
            @movie = Movie.find(id)
        rescue 
            flash[:notice] = "No movie with the given ID could be found."
            redirect_to movies_path
        end
        
    end

    def new
        @movie = Movie.new
    end 



    def create
        params.require(:movie)
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        @movie = Movie.new(permitted)
        if @movie.save
            flash[:notice] = "#{@movie.title} was successfully created."
            redirect_to movies_path
        else
            render 'new'
        end
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        if @movie.update(permitted)
            flash[:notice] = "#{@movie.title} was successfully updated."
            redirect_to movie_path(@movie)
        else
            render 'edit'
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end

	def search_tmdb
	  # hardwire to simulate failure
	  flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
	  redirect_to movies_path
	end
	
end