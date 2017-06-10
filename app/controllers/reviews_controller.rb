class ReviewsController < ApplicationController
  before_action :authenticate

  def create
      review = current_user.reviews.new(review_params)
      if review.save!
        flash[:success] = "评论成功"
        send_modified_notification(review.section.author, review.section)
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
  def send_modified_notification(user,section)
    return if user.subscription.blank?
    message= {
      icon: current_user.avatar_url,
      title: '新的评论', 
      body:  "#{current_user.name} 评论了ES「#{section.title}」点击查看,",
      target_url: section_url(section) 
    }
    Webpush.payload_send webpush_params(user, message)
  end
end
