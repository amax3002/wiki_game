require 'test_helper'

class WikipediaControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   stub_request(
  #      :get,
  #      "https://en.wikipedia.org/wiki/Symphony_X"
  #    ).to_return(
  #      :status => 200,
  #      :body => File.read("test/helpers/response.txt"),
  #      :headers => { 'Content-Type' => 'application/json' }
  #    )
  # end

  # test "should decalre winner" do
  #   new_session(:Alex)
  #   follow_redirect!
  #
  #   a = WebMock.stub_request(:get, 'https://en.wikipedia.org/wiki/Symphony_X')
  #     .to_return(
  #        :status => 200,
  #        :body => File.read("test/helpers/response.txt"),
  #        :headers => { 'Content-Type' => 'application/json' }
  #      )
  #
  #   assert_equal 5000, WikiData.new.word_count("/wiki/Symphony_X")
  # end

end
