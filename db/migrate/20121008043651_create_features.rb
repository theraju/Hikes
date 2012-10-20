class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.text :hash_key
      t.string :name

      t.timestamps
    end
  end
end
