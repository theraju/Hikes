class CreateTrailsFeaturesJoin < ActiveRecord::Migration
  def up
    create_table 'trails_features', :id => false do |t|
        t.column :trails_id, :integer
        t.column :features_id, :integer
    end
  end

  def down
  end
end
