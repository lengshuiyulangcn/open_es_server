class SectionsController < ApplicationController
  before_action :authenticate, except: [:index]
  def index
    @sections = Section.page params[:page]
  end

  def new
    @section = Section.new
  end

  def create
    @section = current_user.created_sections.new(section_params)
    if @section.save
      flash[:success]="创建新的ES草稿成功！"
      redirect_to sections_path
    else
      render :new
    end
  end

  def show
    @section = Section.find(params.permit(:id)[:id])
    @modification = @section.modification
  end


  def assign
    @section = Section.find(params.permit(:id)[:id])
    if can? :assign, @section
      @section.assignee = current_user
      @section.save
      render 'assign'
    else
      head 401
    end
  end

  private

  def section_params
    params.require(:section).permit(:id,:content,:title)
  end
end
