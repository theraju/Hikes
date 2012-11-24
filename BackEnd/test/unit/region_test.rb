require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  test "Should not save region without hash key" do
    region = regions(:one)
    region.hash_key = nil
    assert !region.save, "Saved the region without a hash key."
  end

  test "Should not save region without name" do
    region = regions(:one)
    region.name = nil
    assert !region.save, "Saved the region without a name."
  end
end
