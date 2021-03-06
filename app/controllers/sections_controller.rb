class SectionsController < ApplicationController
  before_action :authenticate, except: [:index]
  def index
    if current_user && !current_user.student?
      @sections = Section
    elsif current_user && current_user.student?
      @sections = Section.where(user_id: current_user.id).or(Section.where(visiable: true))
    else
      @sections = Section.where(visiable: true)
    end
    @sections = @sections.preload(:tags, :author, :assignee, :modification).order("created_at DESC").page params[:page]
  end

  def new
    if can? :create, Section
      @section = Section.new
    else
      flash[:error]="每小时只能发一篇哦！"
      redirect_to sections_path
    end
  end

  def edit
    @section = Section.find(params.permit(:id)[:id])
    unless can? :edit, @section
      flash[:error]="只能编辑自己的内容"
      redirect_to sections_path
    end
  end

  def update
    @section = Section.find(params.permit(:id)[:id])
    if can? :edit, @section
      if @section.update(section_params)
        flash[:success]="更新成功！"
        redirect_to sections_path
      else
        render :edit
      end
    else
      flash[:error]="只能编辑自己的内容"
      redirect_to sections_path
    end
  end

  def create
    unless can? :create, Section
      flash[:error]="每小时只能发一篇哦！"
      redirect_to sections_path
    end
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
    if can? :read, @section
      @reviews = @section.reviews.preload(:user)
      @modification = @section.modification
      @review = Review.new
    else
      flash[:error]="此ES设置成不可见了哦！"
      redirect_to root_path 
    end
  end


  def assign
    @section = Section.find(params.permit(:id)[:id])
    if can? :assign, @section
      @section.assignee = current_user
      @section.save
      WunderlistWorker.perform_async(current_user.id, "修改ES #{@section.title} #{modify_section_url(@section)}")
      render 'assign'
    else
      head 401
    end
  end

  def created
    @sections = current_user.created_sections.preload(:tags, :author, :assignee, :modification).order("created_at DESC").page params[:page]
    render :index
  end

  def assigned
    @sections = current_user.assigned_sections.preload(:tags, :author, :assignee, :modification).order("created_at DESC").page params[:page]
    render :index
  end


  def modify
    @section = Section.find(params.permit(:id)[:id])
    @modification = @section.modification || Modification.new
  end
  private

  def section_params
    params.require(:section).permit(:id,:content,:title, :visiable, :tag_ids=>[])
  end
  
end
