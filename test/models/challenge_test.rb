require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase

  test "check if user exists while sending challenge" do
    b = challenges(:Challenge1).recipient_status_known(users(:Laurent).email)
    assert_equal true, b
  end

end
