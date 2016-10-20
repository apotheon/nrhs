class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update]
  before_action :get_category_id, only: [:create, :update]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
    @category_name = nil
  end

  def show
  end

  def edit
    @category_name = @page.category.name
  end

  def create
    @page = Page.new page_params.merge(category_id: @category_id)

    if @page.save
      redirect_to @page, success: 'Page Created'
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    @page.attributes = page_params.merge(category_id: @category_id)

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
    params.require(:page).permit :title, :body, :id
  end

  def find_category
    Category.find_by name: category_name
  end

  def create_category
    Category.new(name: category_name).save and find_category
  end

  def get_category_id
    @category_id = (find_category or create_category).id
  end

  def category_name
    params[:page][:category]
  end
end
