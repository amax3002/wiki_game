require 'test_helper'

class WikipediaControllerTest < ActionDispatch::IntegrationTest
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



end
