class CreateStreetEvents < ActiveRecord::Migration
  def change
    create_table :street_events do |t|
      t.string :street
      t.string :stretch
      t.date :date
      t.string :time_of_day

      t.timestamps
    end
  end
end
