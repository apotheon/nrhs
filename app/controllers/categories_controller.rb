class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if Category.find_by name: category_params[:name]
      flash[:alert] = "Category #{category_params[:name]} exists."
      render 'new'
    elsif @category.save
      redirect_to @category, success: 'Category Created'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end
end
