class ModificationsController < ApplicationController
  before_action :authenticate
  def create
    section = Section.find(modification_params[:section_id])
    if section.modification.blank?
      current_user.modifications.create(modification_params)
      head :created
    else
      section.modification.update!(modification_params)
      head :ok
    end
  end

  private
  def modification_params
    params.require(:modification).permit(:section_id, :content, :comment)
  end
end