module ApplicationHelper
  def get_active_categories
    Category.joins(:pages).order :name
  end
end
