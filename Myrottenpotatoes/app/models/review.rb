class Review < ActiveRecord::Base
    belongs_to :movie
    belongs_to :moviegoer

    attr_reader :moviegoer_id 
    # review is valid only if it's associated with a movie:
    validates :movie_id, :presence => true

    def self.all_ratings ; %w[1 2 3 4 5] ; end

    # can ALSO require that the referenced movie itself be valid
    #  in order for the review to be valid:
    validates_associated :movie
  end
