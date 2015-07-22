class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :venue, foreign_key: true, index: true

      t.string :name, null: false, index: true
      t.text :description
      t.boolean :recurring, null: false

      t.datetime :starts_at
      t.datetime :ends_at

      t.decimal :price

      t.timestamps null: false
    end
  end
end
