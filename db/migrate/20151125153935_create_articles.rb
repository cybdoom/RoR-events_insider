class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :blog, foreign_key: true, index: true, null: false
      t.string :title, null: false
      t.string :author
      t.text :body
      t.timestamps null: false
    end
  end
end
