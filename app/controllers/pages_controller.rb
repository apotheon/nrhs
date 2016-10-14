class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def show
  end

  def edit
  end

  def create
    @page = Page.new page_params

    if @page.save
      redirect_to @page, success: 'Page Created'
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    @page.attributes = page_params

    if @page.save
      redirect_to @page, success: 'Page Updated'
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

  def find_page
    @page = Page.find params[:id]
  end

  def page_params
    params.require(:page).permit :title, :body
  end
end
