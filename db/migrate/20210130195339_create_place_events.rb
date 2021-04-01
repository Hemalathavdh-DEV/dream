class CreatePlaceEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :place_events do |t|
      t.string :name
      t.decimal :latitude,  { precision: 10, scale: 6 }
      t.decimal :longitude, { precision: 10, scale: 6 }
      t.datetime :date

      t.timestamps
    end
  end
end
