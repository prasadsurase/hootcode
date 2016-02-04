require "test_helper"

describe Team do
  let(:team) { Team.new }

  it "must be valid" do
    value(team).must_be :valid?
  end
end
