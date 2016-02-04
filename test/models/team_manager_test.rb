require "test_helper"

describe TeamManager do
  let(:team_manager) { TeamManager.new }

  it "must be valid" do
    value(team_manager).must_be :valid?
  end
end
