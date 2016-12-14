class CreateHelpDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :help_docs do |t|
      t.string :help_text
    end
  end
end
