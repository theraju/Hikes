class CreateFeaturesTrailsJoin < ActiveRecord::Migration
  def up
    create_table 'features_trails', :id => false do |t|
        t.column :feature_id, :integer
        t.column :trail_id, :integer
    end
  end

  def down
  end
end
