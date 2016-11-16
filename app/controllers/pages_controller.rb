class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :destroy]
  before_action :get_category_id, only: [:create, :update]
  before_action :category_selections, only: [:new, :edit, :update, :create]

  def index
    @pages = Page.all
  end

  def new
    if @category_selections.empty?
      redirect_to new_category_path, alert: 'Please create a category.'
    else
      @page = Page.new
      @category_name = nil
    end
  end

  def show
  end

  def edit
    @category_name = @page.category.name
  end

  def create
    @page = Page.new page_params.merge(category_id: @category_id)

    if page_params[:title].empty?
      @category_name = nil

      flash[:alert] = 'Please supply a page title.'
      render 'new'
    else
      if Page.find_by title: page_params[:title]
        flash[:alert] = "Page #{page_params[:title]} exists."
        render 'new'
      elsif @page.save
        redirect_to @page, notice: 'Page Created'
      else
        flash[:alert] = @page.errors.full_messages.to_sentence
        render 'new'
      end
    end
  end

  def update
    if page_params[:title].empty?
      flash[:alert] = 'Please supply a page title.'
      render 'edit'
    else
      @page.attributes = page_params.merge(category_id: @category_id)

      if @page.save
        redirect_to @page, notice: 'Page Updated'
      else
        flash[:alert] = @page.errors.full_messages.to_sentence
        render 'edit'
      end
    end
  end

  def destroy
    if @page.destroy
      redirect_to pages_path, notice: 'Page Deleted'
    else
      flash[:alert] = @page.errors.full_messages.to_sentence
      render 'show'
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

  def category_selections
    @category_selections = Category.order(:name).map do |category|
      [category.name, category.id]
    end
  end
end
