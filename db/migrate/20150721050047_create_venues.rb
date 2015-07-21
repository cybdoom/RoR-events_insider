class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.belongs_to :location, null: false, foreign_key: true, index: true
      t.belongs_to :owner, null: false, foreign_key: true, index: true
      t.belongs_to :organization, null: false, foreign_key: true, index: true

      t.string :name
      t.string :image
      t.integer :size

      t.timestamps null: false
    end
  end
end
