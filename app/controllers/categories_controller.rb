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
      flash[:alert] = "Category #{category_params[:name]} exists."
      render 'new'
    elsif category_params[:name].empty?
      flash[:alert] = 'Please supply a category name.'
      render 'new'
    elsif @category.save
      redirect_to @category, notice: 'Category Created'
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if category_params[:name].empty?
      flash[:alert] = 'Please supply a category name.'
      render 'edit'
    else
      @category.attributes = category_params

      if @category.save
        redirect_to @category, notice: 'Category Updated'
      else
        flash[:alert] = @category.errors.full_messages.to_sentence
        render 'edit'
      end
    end
  end

  def destroy
    if @category.destroy
      redirect_to category_path, notice: 'Page Deleted'
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      render 'show'
    end
  end

  private

  def find_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :body
  end
end
