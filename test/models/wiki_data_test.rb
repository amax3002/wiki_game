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
    stub_request(:get, "http://wiki/Ottoman_Empire").
  with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "", :headers => {})
  end

  test "should get split clean url path" do
    b = games(:Game1).start_point
    assert_equal "Ottoman_Empire", WikiData.new.params_path_formatter(b)
  end

  test "should array of links" do
    b = games(:Game1).start_point
    assert_equal "Ottoman_Empire", WikiData.new.links_to_check_cheating(b)
  end
end
