class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.timestamps null: false
    end
  end
end
