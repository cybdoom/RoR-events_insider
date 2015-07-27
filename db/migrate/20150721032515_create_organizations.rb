class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.belongs_to :location, null: false, foreign_key: true, index: true
      t.belongs_to :user, null: false, foreign_key: true, index: true

      t.string :name, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
