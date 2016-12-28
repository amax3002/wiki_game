require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should get split clean url path" do
    b = games(:Game1).start_point
    assert_equal "Ottoman_Empire", WikiData.new.name_url_path_end_point_match(b)
  end
end
