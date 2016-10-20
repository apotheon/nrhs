module ApplicationHelper
  def get_active_categories
    Category.joins :pages
  end
end
