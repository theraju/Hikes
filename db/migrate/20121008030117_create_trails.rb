class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :title
      t.decimal :avg_rating, :precision => 3, :scale => 2
      t.integer :vote_count
      t.string :photo_url
      t.decimal :round_trip, :precision => 6, :scale => 2
      t.decimal :elevation_gain, :precision => 6, :scale => 2
      t.decimal :high_point, :precision => 6, :scale => 2
      t.text :description
      t.timestamps
    end
  end
end
