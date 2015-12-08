class AddOldSlugToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :old_slug, :string
  end
end
