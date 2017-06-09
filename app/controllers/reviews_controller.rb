class ReviewsController < ApplicationController
  before_action :authenticate

  def create
      review = current_user.reviews.new(review_params)
      if review.save!
        flash[:success] = "评论成功"
        redirect_to section_path(review.section)
      else
        flash[:success] = "评论失败"
        redirect_to section_path(review.section)
      end
  end

  private
  def review_params
    params.require(:review).permit(:section_id, :content, :rating)
  end
end
