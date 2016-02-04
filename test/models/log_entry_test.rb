require "test_helper"

describe LogEntry do
  let(:log_entry) { LogEntry.new }

  it "must be valid" do
    value(log_entry).must_be :valid?
  end
end
