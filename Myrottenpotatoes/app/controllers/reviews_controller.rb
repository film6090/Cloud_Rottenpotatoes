class ReviewsController < ApplicationController
    before_action :has_moviegoer_and_movie, :except => [:index]
    protected
    
    
    def has_moviegoer_and_movie
      unless @current_user
        flash[:warning] = 'You must be logged in to create a review.'
        redirect_to movies_path
      end

      unless (@movie = Movie.find(params[:movie_id]))
        flash[:warning] = 'Review must be for an existing movie.'
        redirect_to movies_path
      end
    end
    
    public
    
    def index
      @movie = Movie.find params[:movie_id]
      @moviegoer = Moviegoer.all
    end

    def new
        @review = @movie.reviews.build
    end
    
    def create
        permitted = params[:review].permit(:potatoes, :comments, :moviegoer_id, :movie_id)
        @review = @movie.reviews.build(permitted)
        @current_user.reviews << @review
        if @review.save
			    flash[:notice] = 'Review successfully create.'
			    redirect_to movie_path(@movie)
		    else
			    render :action => 'new'
		    end
    end
     

     def edit
		    @movie = Movie.find params[:movie_id]
     end

     def update
		    @movie = Movie.find(params[:movie_id])
		    permitted = params[:review].permit(:potatoes, :comments, :moviegoer_id, :movie_id)
		    @review = @movie.reviews.update(permitted)
        if @review
			    flash[:notice] = 'Review successfully update.'
			    redirect_to movie_review_path(@movie)
		    else
			    render  'edit'
		    end
    end
     
    def show
        id = params[:movie_id]
        begin
            @movie = Movie.find(id)
        rescue 
            flash[:notice] = "No movie with the given ID could be found."
            redirect_to movie_path
        end
    end
end
