class Account::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = current_user.reviews.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
    @movie = Moive.find(params[:movie_id])
    @review = Rview.find(params[:id])
  end

  def updated
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to reviews_path(@review), notice: "Updated review"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path(@review), alert: "Review deleted"
  end


  private

  def review_params
    params.require(:review).permit(:content)
  end
end
