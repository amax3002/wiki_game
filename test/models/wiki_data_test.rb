require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Symphony_X"
    ).to_return(
      status: 200,
      body: File.read("test/fixtures/wikiepedia_responses/symphony_x.html"),
      headers: { "Content-Type" => "text/html" }
    )
    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Ottoman_Empire"
    ).to_return(
      status: 200,
      body: File.read("test/fixtures/wikiepedia_responses/ottoman_empire.html"),
      headers: { "Content-Type" => "text/html" }
    )

    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Special:Random"
    ).to_return(
      {
        status: 302,
        body: "",
        headers: { "Location" => "https://en.wikipedia.org/wiki/Ottoman_Empire" }
      },
      status: 302,
      body: "",
      headers: { "Location" => "https://en.wikipedia.org/wiki/Symphony_X" }
    )
  end

  test "should get split clean url path" do
    b = games(:Game1).start_point
    assert_equal "Ottoman_Empire", WikiData.new.params_path_formatter(b)
  end

  test "should array of links" do
    b = games(:Game1).start_point
    assert_equal 1116, (WikiData.new.links_to_check_cheating("https://en.wikipedia.org#{b}")).size
  end

  test "cheating test start of game" do
    a = WikiData.new.cheating_test("Start of Game", "not used")
    assert_equal true, a
  end

  test "cheating test cheating" do
    a = WikiData.new.cheating_test("Are you trying to cheat??", "not used")
    assert_equal false, a
  end

  test "pulling link into cheating array" do
    a = WikiData.new.links_to_check_cheating("https://en.wikipedia.org/wiki/Ottoman_Empire")
    assert_equal 1116, a.size
  end

  # test "match links cheating" do
  #   a = WikiData.new.cheating_test("/Are you trying to cheat??", "Are you trying to cheat??")
  #   assert_equal false, a
  # end
end
