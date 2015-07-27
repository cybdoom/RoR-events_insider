class UserBelongsToLocation < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :location, foreign_key: true, index: true
    end
  end
end
