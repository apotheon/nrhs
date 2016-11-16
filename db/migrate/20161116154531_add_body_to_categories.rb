class AddBodyToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :body, :text
  end
end
