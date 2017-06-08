class ModificationsController < ApplicationController
  before_action :authenticate
  def update
    section = Section.find(modification_params[:section_id])
    if section.modification.blank? && can?(:update, Modification)
      current_user.modifications.create(modification_params)
      head :created
    elsif can? :update, section.modification
      section.modification.update!(modification_params)
      flash[:success] = "提交批改成功！"
      redirect_to :root
    else
      flash[:success] = "提交失败！"
      redirect_to :back
    end
  end

  private
  def modification_params
    params.require(:modification).permit(:section_id, :content, :comment, :highlighted_content)
  end
end
