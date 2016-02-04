require "test_helper"

describe MutedSubmission do
  let(:muted_submission) { MutedSubmission.new }

  it "must be valid" do
    value(muted_submission).must_be :valid?
  end
end
