require "test_helper"

describe Submission do
  let(:submission) { Submission.new }

  it "must be valid" do
    value(submission).must_be :valid?
  end
end
