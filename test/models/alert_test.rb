require "test_helper"

describe Alert do
  let(:alert) { Alert.new }

  it "must be valid" do
    value(alert).must_be :valid?
  end
end
