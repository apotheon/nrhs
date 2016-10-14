class PagesController < ApplicationController
  def index
  end

  def new
    @page = Page.new
  end

  def show
    @page = Page.find params[:id]
  end

  def create
    @page = Page.new page_params

    if @page.save
      redirect_to page_path @page, success: 'Page Created'
    else
      redirect_to new_page_path, alert: 'Failed To Create Page'
    end
  end

  private

  def page_params
    params.require(:page).permit :title, :body
  end
end
