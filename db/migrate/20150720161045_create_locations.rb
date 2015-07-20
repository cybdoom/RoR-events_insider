class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      # actual location as typed in by user, usually == geocoded_location
      t.string :location, null: false
      t.string :geocoded_location # as geocoded by geocoder gem

      t.string :country_code, limit: 2 # alpha2 ISO country code
      t.string :region_code
      t.string :subregion_code
      t.string :city
      t.string :street
      t.string :street_number

      t.string :postcode

      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    # TODO: indices
    add_index :locations, [:latitude, :longitude], using: :gin
  end
end
