class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.belongs_to :location, null: false, foreign_key: true, index: true
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :organization, foreign_key: true, index: true

      t.string :name
      t.text :description
      t.integer :size

      t.timestamps null: false
    end
  end
end
