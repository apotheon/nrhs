class CategoryNameAndPageTitle < ActiveRecord::Migration[5.0]
  def change
    change_column_null :categories, :name, false
    change_column_null :pages, :title, false
  end
end
