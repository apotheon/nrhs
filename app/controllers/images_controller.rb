class ImagesController < ApplicationController
  include UserHelper

  before_action :redirect_non_admin

  def index
  end

  def new
  end
end
