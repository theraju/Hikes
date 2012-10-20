class Feature < ActiveRecord::Base
  attr_accessible :hash_key, :name
  has_and_belongs_to_many :trails
  validates :hash_key, :name, :presence=>true
end
