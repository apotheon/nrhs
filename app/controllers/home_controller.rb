class HomeController < ApplicationController
  before_action :get_home_content, only: [:edit, :show, :update]
  def index
    show
    render :show
  end

  def show
    get_home_content
  end

  def edit
    get_home_content
  end

  def update
    @home.attributes = home_params.merge(id: Home.first.id)

    if @home.save
      redirect_to root_path, notice: 'Page Updated'
    else
      flash[:alert] = @home.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

  def get_home_content
    unless Home.first
      Home.new.save
    end

    @home = Home.first
  end

  def home_params
    params.require(:home).permit :title, :body
  end
end
