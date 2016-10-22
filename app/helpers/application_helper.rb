module ApplicationHelper
  def get_active_categories
    Category.order(:name).reject {|c| c.pages.empty? }
  end
end
