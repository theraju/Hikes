require 'test_helper'

class TrailTest < ActiveSupport::TestCase
  test "should not save trail without title" do
    trail = trails(:tiger3)
    trail.title = nil
    assert !trail.save, "Saved the trail without a title."
  end

  test "should not save trail without hashkey" do
    trail = trails(:tiger3)
    trail.hash_key = nil
    assert !trail.save, "Saved the trail without a hashkey."
  end

  test "should save trail with avg_rating and no votes" do
    trail = trails(:tiger3)
    trail.avg_rating = 0
    trail.vote_count = 0
    assert trail.save, "Did not save trail with no reviews."
  end

  test "should not save trail with avg_rating but no votes" do
    trail = trails(:tiger3)
    trail.avg_rating = 0
    trail.vote_count = 10
    assert !trail.save, "Saved trail with no votes but has avg_rating."
  end
    
  test "should not save trail without 0 round trip" do
    trail = trails(:tiger3)
    trail.round_trip = 0
    assert !trail.save, "Saved the trail with 0 round trip."
  end

  test "should not save trail with negative round trip" do
    trail = trails(:tiger3)
    trail.round_trip = -1
    assert !trail.save, "Saved the trail with negative round trip."
  end
end
