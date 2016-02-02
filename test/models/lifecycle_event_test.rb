require "test_helper"

class LifecycleEventTest < ActiveSupport::TestCase
  def lifecycle_event
    @lifecycle_event ||= LifecycleEvent.new
  end

  def test_valid
    assert lifecycle_event.valid?
  end
end
