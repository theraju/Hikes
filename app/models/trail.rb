class Trail < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :features
  set_primary_key :title
end
