class AddPageTitleIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :pages, :title, unique: true
  end
end
