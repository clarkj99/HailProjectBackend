class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.datetime :time
      t.integer :size
      t.string :location
      t.string :city
      t.string :county
      t.string :state
      t.float :lat
      t.float :lon
      t.string :comments
      t.string :filename

      t.timestamps
    end
  end
end
