class ModificationsController < ApplicationController
  before_action :authenticate
  def create
    section = Section.find(modification_params[:section_id])
    if section.modification.blank? && can?(:update, Modification)
      current_user.modifications.create(modification_params)
      flash[:success] = "提交批改成功！"
      NotifyWorker.perform_async(section.author.id, current_user.id, section.id, :modification)
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
      NotifyWorker.perform_async(section.author.id, current_user.id, section.id, :modification)
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

end
