require "test_helper"

describe UserExercise do
  let(:user_exercise) { UserExercise.new }

  it "must be valid" do
    value(user_exercise).must_be :valid?
  end
end
