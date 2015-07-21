class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.belongs_to :owner, null: false, foreign_key: true, index: true
      t.belongs_to :location, null: false, foreign_key: true, index: true

      t.string :name, null: false
      t.string :image

      t.timestamps null: false
    end
  end
end
