require 'red_rug'

module ApplicationHelper
  def get_active_categories
    Category.order(:name).reject {|c| c.pages.empty? }
  end

  def markdown text
    # see RedRug documentation here:
    # http://fossrec.com/u/apotheon/redrug/index.cgi/home

    text ? RedRug.to_html(text).html_safe : nil
  end
end
