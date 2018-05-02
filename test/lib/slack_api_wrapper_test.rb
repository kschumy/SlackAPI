require 'test_helper'

describe SlackApiWrapper do

	it "Can send valid message to real channel" do
		message = "test message"
	  VCR.use_cassette("channels") do
	    response = SlackApiWrapper.send_message("CAGCPB64A", message)
			## how to test if you decide not the return the response and instead just
			## want to see if it worked
			# response.must_equal true
			response["ok"].must_equal true
	    response["message"]["text"].must_equal message
	  end
	end

	it "Can't send message to fake channel" do
	  VCR.use_cassette("channels") do
	    response = SlackApiWrapper.send_message("this-channel-does-not-exist",
				"test message")
	    response["ok"].must_equal false
	    response["error"].wont_be_nil
	  end
	end
end
