require "test_helper"

describe TeamMembership do
  let(:team_membership) { TeamMembership.new }

  it "must be valid" do
    value(team_membership).must_be :valid?
  end
end
