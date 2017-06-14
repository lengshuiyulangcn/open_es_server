class ReviewsController < ApplicationController
  before_action :authenticate

  def create
      review = current_user.reviews.new(review_params)
      if review.save!
        flash[:success] = "评论成功"
        send_messages_to_ids = review.section.message_recevers_ids  - [current_user.id]
        NotifyWorker.perform_async( send_messages_to_ids,
review.section.author.id, current_user.id, review.section.id, :review)
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
