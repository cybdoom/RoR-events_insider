class AddSlugToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.string :slug
    end
  end
end
