class ModificationsController < ApplicationController
  before_action :authenticate
  def create
    section = Section.find(modification_params[:section_id])
    if section.modification.blank? && can?(:update, Modification)
      current_user.modifications.create(modification_params)
      flash[:success] = "提交批改成功！"
      send_modified_notification(section.author,section)
      redirect_to :root
    else
      flash[:success] = "提交失败！"
      redirect_to :back
    end
  end
  def update
    section = Section.find(modification_params[:section_id])
    if can? :update, section.modification
      section.modification.update!(modification_params)
      flash[:success] = "提交批改成功！"
      send_modified_notification(section.author,section)
      redirect_to :root
    else
      flash[:success] = "提交失败！"
      redirect_to :back
    end
  end

  private
  def modification_params
    params.require(:modification).permit(:section_id, :content)
  end

  def send_modified_notification(user,section)
    return if user.subscription.blank?
    message= {
      icon: current_user.avatar_url,
      title: 'ES已经批改', 
      body:  "#{current_user.name} 修改了你的ES",
      target_url: section_url(section) 
    }
    Webpush.payload_send webpush_params(user, message)
  end
end
