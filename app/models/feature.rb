class Feature < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :trails
  validates :name, :presence=>true
end
