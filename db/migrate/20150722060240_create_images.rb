class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :imageable, polymorphic: true, index: true

      t.image :image

      t.timestamps null: false
    end
  end
end
