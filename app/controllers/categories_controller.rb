class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order(:name)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params

    if Category.find_by name: category_params[:name]
      render_alert "Category #{category_params[:name]} exists."
    elsif category_params[:name].empty?
      render_alert 'Please supply a category name.'
    elsif @category.save
      redirect_to @category, notice: 'Category Created'
    else
      render_alert @category.errors.full_messages.to_sentence
    end
  end

  def update
    if category_params[:name].empty?
      render_alert 'Please supply a category name.', 'edit'
    else
      @category.attributes = category_params

      if @category.save
        redirect_to @category, notice: 'Category Updated'
      else
        render_alert @category.errors.full_messages.to_sentence, 'edit'
      end
    end
  end

  def destroy
    if @category.destroy
      redirect_to category_path, notice: 'Page Deleted'
    else
      render_alert @category.errors.full_messages.to_sentence, 'show'
    end
  end

  private

  def find_category
    @category = Category.find params[:id]
  end

  def render_alert message, view='new'
    flash[:alert] = message
    render view
  end

  def category_params
    params.require(:category).permit :name, :body
  end
end
