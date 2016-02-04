require "test_helper"

describe SubmissionViewer do
  let(:submission_viewer) { SubmissionViewer.new }

  it "must be valid" do
    value(submission_viewer).must_be :valid?
  end
end
