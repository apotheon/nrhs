class Category < ApplicationRecord
  has_many :pages, dependent: :destroy

  def sorted_pages
    pages.sort_by {|page| page.title }
  end
end
