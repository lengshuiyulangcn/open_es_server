class SectionsController < ApplicationController
  before_action :authenticate, except: [:index]
  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params.permit(:id)[:id])
    @modification = @section.modification
  end

end
