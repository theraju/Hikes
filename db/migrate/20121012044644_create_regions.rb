class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.text :hash_key
      t.string :name

      t.timestamps
    end
  end
end
