class Region < ActiveRecord::Base
  attr_accessible :hash_key, :name
  has_many :trails
  validates :hash_key, :name, :presence=>true
end
