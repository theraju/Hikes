require 'test_helper'

class FeatureTest < ActiveSupport::TestCase

  test "Should not save feature without hash key" do
    feature = features(:one)
    feature.hash_key = nil
    assert !feature.save, "Saved the feature without a hash key."
  end

  test "Should not save feature without name" do
    feature = features(:one)
    feature.name = nil
    assert !feature.save, "Saved the feature without a name."
  end
  # test "the truth" do
  #   assert true
  # end
end
