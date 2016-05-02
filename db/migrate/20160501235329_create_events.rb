class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :event
      t.datetime :start_time
      t.timestamps null: false
    end
  end
end
