class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :venue, foreign_key: true, index: true

      t.string :name, null: false, default: '', index: true
      t.text :description
      t.boolean :recurring, null: false, default: false

      t.datetime :starts_at
      t.datetime :ends_at

      t.integer :price, null: false, default: 0
      t.integer :estimated_attendance, null: false, default: 0

      t.timestamps null: false
    end
  end
end
